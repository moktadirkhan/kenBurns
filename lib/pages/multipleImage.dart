// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_zoom/pages/singleImage.dart';
import 'package:image_zoom/pages/singleImage_for_export.dart';
import 'package:image_zoom/services/ffmpeg_execution.dart';
import 'package:image_zoom/services/temporary_file_path.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:video_editor/video_editor.dart';
import '../services/editor/add_files.dart';
import '../services/editor/capturePngToUint8.dart';
import '../services/editor/dialog_box.dart';
import '../services/editor/write_file.dart';
import '../widgets/animation_timer_widgets.dart';

AnimationController? controller;
// AnimationController? animationController;
Duration perAnimation = Duration(milliseconds: 5000);
Duration transitionTime = Duration(milliseconds: 500);
double perAnimationIntervalValue = 0;
// GlobalKey globalKey = GlobalKey();
final animationWidgets = [];

class MultipleImages extends StatefulWidget {
  final List<File> files;

  const MultipleImages({Key? key, required this.files}) : super(key: key);

  @override
  _MultipleImagesState createState() => _MultipleImagesState();
}

class _MultipleImagesState extends State<MultipleImages>
    with TickerProviderStateMixin {
  VideoEditorController? videoController;
  int? index = 0;
  int? index1 = 0;
  bool showDialog = false;
  late final Timer timer;
  double _currentSliderValue = 0;
  Duration transitionTime = Duration(milliseconds: 500);
  Animation? animationValue;
  double t = 0;
  int i = 1;
  final animationWidgets1 = [];
  List<Future<void>> fileWriterFutures = [];
  List<AnimationController> animationControllerList = [];
  List<GlobalKey> globalKeyList = [];
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    perAnimationIntervalValue = 1 / widget.files.length;

    controller = AnimationController(
      vsync: this,
      duration: ((perAnimation + transitionTime) * widget.files.length),
    )..addListener(() {
        setState(() {
          _currentSliderValue = controller!.value;
          controller!.value != 1
              ? index = controller!.value ~/ perAnimationIntervalValue
              : controller!.stop();
        });
      });

    // addFiles(widget.files);
    generateAnimationController();
    differentParentAssign();
    controller!.forward();
    super.initState();
  }

  void generateAnimationController() async {
    for (var i = 0; i < widget.files.length; i++) {
      AnimationController? animationControllers =
          AnimationController(vsync: this, duration: perAnimation);
      animationControllerList.add(animationControllers);
    }
  }

  void differentParentAssign() async {
    for (var i = 0; i < widget.files.length; i++) {
      GlobalKey globalKey = GlobalKey();
      animationWidgets1.add(SingleImageForExport(
        globalKey: globalKey,
        animationController: animationControllerList[i],
        image: widget.files[i].path,
        key: Key('${i + 1}'),
      ));
      print("GlobalKey $globalKey");
      Future.delayed(Duration(seconds: 1), () {
        int startKey = 1;
        int endKey = perAnimation.inSeconds.toInt() * 25;
        // int totalFrameForOnerImage = ;
        print("start ${(startKey * i) + (endKey * i)}");
        print("endKey ${(endKey * i) + endKey}");
        captureImage(animationControllerList[i], globalKey,
            (startKey * i) + (endKey * i), (endKey * i) + endKey);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ken Burns Effect"),
        actions: [
          IconButton(
              onPressed: () {
                // captureImage();
                setState(() {
                  showDialog = true;
                });
              },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: animationWidgets1[0],
            ),
            Container(
              child: animationWidgets1[1],
            ),
            // Container(
            //   child: animationWidgets1[1],
            // ),

            // ClipRect(
            //   child: AnimatedSwitcher(
            //     duration: transitionTime,
            //     child: animationWidgets1[1],
            //   ),
            // ),

            // ClipRect(
            //   child: RepaintBoundary(
            //     key: globalKey,
            //     child: AnimatedSwitcher(
            //       duration: transitionTime,
            //       child: animationWidgets[index!],
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   child: Row(
            //     children: [
            //       Text(timerString),
            //       Spacer(),
            //       Text(totalDurationString)
            //     ],
            //   ),
            // ),
            // Slider(
            //     value: controller!.value,
            //     label: _currentSliderValue.round().toString(),
            //     activeColor: Colors.blueAccent,
            //     inactiveColor: Colors.grey[700],
            //     onChanged: (double value) {
            //       setState(() {
            //         controller!.value = value;
            //       });
            //     }),
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              controller!.forward();
            },
            child: const Text("Start"),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              controller!.stop();
            },
            child: const Text("Stop"),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              controller!.reset();
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> capturePngToUint8List(
      GlobalKey<State<StatefulWidget>> globalKey) async {
    try {
      RenderRepaintBoundary? boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // pixelratio allows you to render it at a higher resolution than the actual widget in the application.
      ui.Image image = await boundary.toImage(pixelRatio: 2);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // print("PngBytes $pngBytes");
      return pngBytes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void captureImage(
      AnimationController animationControllers,
      GlobalKey<State<StatefulWidget>> globalKey,
      int startKey,
      int endKey) async {
    ProgressDialog pd = ProgressDialog(context: context);
    // TemporaryFile.deleteDir();
    print("Animation $animationControllers");
    Map<int, Uint8List> frames = {};
    double dt = (1 / 25) / animationControllers.duration!.inSeconds.toDouble();
    // TemporaryFile.deleteDir();
    while (t <= 1.0) {
      print("Rendering... ${t * 100}%");
      showDialog ? await dialogBox(pd, (t * 100).toInt()) : Container();
      var bytes = await capturePngToUint8List(globalKey);
      frames[i] = bytes;

      t += dt;
      setState(() {
        animationControllers.value = t;
      });
      i++;
    }
    frames.forEach((key, value) async {
      fileWriterFutures.add(writeFile(
          bytes: value,
          location:
              "${await TemporaryFile.tmpFilePath()}/" + "frame_$key.png"));
    });
    // addToFrames(frames);
    await Future.wait(fileWriterFutures);
    // FfmpegExecution().runFFmpeg(context);
  }

  void addToFrames(Map<int, Uint8List> frames) async {}
}

// Map<int,List<Frames>>
    // animationController = AnimationController(
    //   vsync: this,
    //   duration: ((perAnimation + transitionTime) * widget.files.length),
    // )..addListener(() {
    //     setState(() {
    //       // _currentSliderValue = controller!.value;
    //       animationController!.value != 1
    //           ? index1 = animationController!.value ~/ perAnimationIntervalValue
    //           : animationController!.stop();
    //     });
    //   });
    // addFiles1(widget.files);
    // captureImage(videoController, widget.files);
    // Future.delayed(Duration(seconds: 1), () {
    //   captureImage(videoController);
    // });
              // Visibility(
          //   visible: true,
          //   child: RepaintBoundary(
          //     key: globalKey,
          //     child: AnimatedSwitcher(
          //       duration: transitionTime,
          //       child: animationWidgets1[index1!],
          //     ),
          //   ),
          // ),

      // void addFiles1(List<File> files) async {
  //   for (var i = 0; i < files.length; i++) {
  //     animationWidgets1.add(
  //       SingleImageForExport(
  //         image: files[i].path,
  //         perAnimation: perAnimation,
  //         startZoomValue: perAnimationIntervalValue * i,
  //         endZoomValue:
  //             (perAnimationIntervalValue / 2) + (perAnimationIntervalValue * i),
  //         startSlidingValue:
  //             (perAnimationIntervalValue / 2) + (perAnimationIntervalValue * i),
  //         endSlidingValue:
  //             (perAnimationIntervalValue * i) + perAnimationIntervalValue,
  //         key: Key('${i + 1}'),
  //       ),
  //     );
  //   }
  // }

    // timer = Timer.periodic(perAnimation, (timer) {
    //   setState(() {
    //     final isLastIndex = index == widgets.length - 1;
    //     // isLastIndex ? 0 : index++;
    //     isLastIndex ? {0, timer.cancel()} : index++;
    //   });
    // });
    // void currentIndex() async {
    //   setState(() {});
    // }