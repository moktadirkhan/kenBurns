// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_zoom/pages/homepage.dart';

AnimationController? controller;

class MultipleImages extends StatefulWidget {
  const MultipleImages({Key? key}) : super(key: key);

  @override
  _MultipleImagesState createState() => _MultipleImagesState();
}

class _MultipleImagesState extends State<MultipleImages>
    with TickerProviderStateMixin {
  int index = 0;
  late final Timer timer;
  double _currentSliderValue = 0;
  static Duration perAnimation = Duration(milliseconds: 10000);
  Duration transitionTime = Duration(milliseconds: 0);
  Animation? animationValue;

  int currentIndex = 0;
  int repeat = 4;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: ((perAnimation) * 4));

    animationValue = Tween<double>(begin: 0.0, end: 3.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.linear)
          ..addListener(() {
            setState(() {
              _currentSliderValue = animationValue!.value;
            });
          }));

    // timer = Timer.periodic(perAnimation, (timer) {
    //   setState(() {
    //     final isLastIndex = index == widgets.length - 1;
    //     // isLastIndex ? 0 : index++;
    //     isLastIndex ? {0, timer.cancel()} : index++;
    //   });
    // });
    controller!.forward();
    super.initState();
  }

  final widgets = [
    HomePage(
      image: "assets/photo1.jpg",
      perAnimation: perAnimation,
      startZoomValue: 0.0,
      endZoomValue: 0.125,
      startSlidingValue: 0.125,
      endSlidingValue: 0.25,
      key: Key('1'),
    ),
    HomePage(
      image: "assets/photo2.jpg",
      perAnimation: perAnimation,
      startZoomValue: 0.25,
      endZoomValue: 0.375,
      startSlidingValue: 0.375,
      endSlidingValue: 0.5,
      key: Key('2'),
    ),
    HomePage(
      image: "assets/photo3.jpg",
      perAnimation: perAnimation,
      startZoomValue: 0.5,
      endZoomValue: 0.625,
      startSlidingValue: 0.625,
      endSlidingValue: 0.75,
      key: Key('3'),
    ),
    HomePage(
      image: "assets/photo2.jpg",
      perAnimation: perAnimation,
      startZoomValue: 0.75,
      endZoomValue: 0.875,
      startSlidingValue: 0.875,
      endSlidingValue: 1,
      key: Key('4'),
    ),
  ];

  String get timerString {
    Duration duration = controller!.duration! * controller!.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String get totalDurationString {
    Duration duration = controller!.duration!;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    print(_currentSliderValue.toInt());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ken Burns Effect"),
      ),
      body: Column(
        children: [
          ClipRect(
            child: AnimatedSwitcher(
              duration: transitionTime,
              child: widgets[_currentSliderValue.toInt()],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Text(timerString),
                Spacer(),
                Text(totalDurationString)
              ],
            ),
          ),
          Slider(
              value: controller!.value,
              label: _currentSliderValue.round().toString(),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey[700],
              onChanged: (double value) {
                setState(() {
                  controller!.value = value;
                });
              }),
        ],
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
}


      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.arrow_forward_ios),
      //   onPressed: () {
      //     final isLastIndex = index == widgets.length - 1;

      //     setState(() => index = isLastIndex ? 0 : index + 1);
      //   },
      // ),