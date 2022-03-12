import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_zoom/pages/multipleImage.dart';
import 'package:image_zoom/pages/pick_image_page.dart';
import 'package:image_zoom/pages/video_preview_page.dart';
import 'package:image_zoom/services/export_to_video.dart';
import 'package:video_editor/domain/bloc/controller.dart';

import 'pages/singleImage.dart';
import 'utils/fade_in_route.dart';

typedef RouterMethod = PageRoute Function(RouteSettings, Map<String, String>);

/*
* Page builder methods
*/
final Map<String, RouterMethod> _definitions = {
  '/': (settings, _) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return const PickImagePage();
      },
    );
  },
  // '/multipleImages': (settings, _) {
  //   return MaterialPageRoute(
  //     settings: settings,
  //     builder: (context) {
  //       return const MultipleImages();
  //     },
  //   );
  // },
};

Map<String, String>? _buildParams(String key, String name) {
  final uri = Uri.parse(key);
  final path = uri.pathSegments;
  final params = Map<String, String>.from(uri.queryParameters);

  final instance = Uri.parse(name).pathSegments;
  if (instance.length != path.length) {
    return null;
  }

  for (int i = 0; i < instance.length; ++i) {
    if (path[i] == '*') {
      break;
    } else if (path[i][0] == ':') {
      params[path[i].substring(1)] = instance[i];
    } else if (path[i] != instance[i]) {
      return null;
    }
  }
  return params;
}

Route buildRouter(RouteSettings settings) {
  print('VisitingPage: ${settings.name}');

  for (final entry in _definitions.entries) {
    final params = _buildParams(entry.key, settings.name!);
    if (params != null) {
      print('Visiting: ${entry.key} for ${settings.name}');
      return entry.value(settings, params);
    }
  }

  print('<!> Not recognized: ${settings.name}');
  return FadeInRoute(
    settings: settings,
    maintainState: false,
    builder: (_) {
      return Scaffold(
        body: Center(
          child: Text(
            '"${settings.name}"\nYou should not be here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey[600],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    },
  );
}

void openHomePage(BuildContext context) {
  Navigator.of(context).pushNamed("/");
}

void openMultipleImage(BuildContext context, List<File> files) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultipleImages(files: files),
    ),
  );
}

// void openExportToVideo(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ExportToVideo(),
//     ),
//   );
// }

void openVideoPreviewPage(
    BuildContext context, VideoEditorController _controller) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => VideoPreviewPage(controller: _controller),
    ),
  );
}
