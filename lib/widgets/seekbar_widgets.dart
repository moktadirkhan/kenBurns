import 'package:flutter/material.dart';
import 'package:image_zoom/widgets/timer_widgets.dart';
import 'package:video_editor/domain/bloc/controller.dart';
import 'package:video_editor/video_editor.dart';


Widget seekbar(VideoEditorController _controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      seekTime(_controller),
      Container(
          // height: 187.4,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TrimSlider(
            controller: _controller,
          ))
    ],
  );
}
