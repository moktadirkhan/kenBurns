// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_zoom/pages/multipleImage.dart';
// import 'package:image_zoom/services/ffmpeg_execution.dart';
// import 'package:image_zoom/services/temporary_file_path.dart';
// import 'package:sn_progress_dialog/sn_progress_dialog.dart';
// import 'package:video_editor/domain/bloc/controller.dart';
// import 'dart:ui' as ui;
// import '../pages/singleImage.dart';

// Future<Uint8List> capturePngToUint8List() async {
//   try {
//     // renderBoxKey is the global key of my RepaintBoundary
//     RenderRepaintBoundary? boundary =
//         globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     // RenderRepaintBoundary boundary = globalKey as RenderRepaintBoundary;
//     // pixelratio allows you to render it at a higher resolution than the actual widget in the application.
//     ui.Image image = await boundary.toImage(pixelRatio: 2);
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();
//     print("PngBytes $pngBytes");
//     return pngBytes;
//   } catch (e) {
//     print(e);
//     rethrow;
//   }
// }

// void captureImage(ProgressDialog pd, VideoEditorController? videoController,
//     List<File> files) async {
//   AnimationController? animationController;
//   // ProgressDialog pd = ProgressDialog(context: context);

//   Map<int, Uint8List> frames = {};
//   double dt = (1 / 25) / controller!.duration!.inSeconds.toDouble();

//   double t = 0;
//   int i = 1;
//   List<Future<void>> fileWriterFutures = [];

//   while (t <= 1.0) {
//     print("Rendering... ${t * 100}%");
//     // await dialogBox(pd, (t * 100).toInt());
//     var bytes = await capturePngToUint8List();

//     frames[i] = bytes;

//     t += dt;
//     // setState(() {
//     animationController!.value = t;
//     // });
//     i++;
//   }
//   frames.forEach((key, value) async {
//     fileWriterFutures.add(writeFile(
//         bytes: value,
//         location: "${await TemporaryFile.tmpFilePath()}/" + "frame_$key.png"));
//   });

//   await Future.wait(fileWriterFutures);
//   // FfmpegExecution().runFFmpeg(videoController);
// }

// Future<File> writeFile(
//     {required String location, required Uint8List bytes}) async {
//   File file = File(location);
//   return file.writeAsBytes(bytes);
// }

// Future<void> dialogBox(ProgressDialog pd, int value) async {
//   pd.show(
//     max: 100,
//     msg: "Preparing Video",
//     progressType: ProgressType.valuable,
//     backgroundColor: const Color(0xff212121),
//     progressValueColor: const Color(0xff3550B4),
//     progressBgColor: Colors.white70,
//     msgColor: Colors.white,
//     valueColor: Colors.white,
//   );
//   pd.update(value: value);
// }

// Widget build(BuildContext context) {
//   return Scaffold();
// }
