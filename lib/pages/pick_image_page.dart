import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_zoom/router.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({Key? key}) : super(key: key);

  @override
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blue, title: const Text("Video Editor Pro")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => pickImages(context),
              child: const Text("Pick Image"),
            ),
          ],
        ),
      ),
    );
  }

  void pickImages(BuildContext context) async {
    final List<XFile>? file = await _picker.pickMultiImage();

    final List<File> files = [];

    for (var i = 0; i < file!.length; i++) {
      files.add(File(file[i].path));
    }

    openMultipleImage(context, files);
    // FfmpegExecution.photoToVideoExecution(durationPerPic, context);
  }
}
