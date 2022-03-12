 
//  import 'dart:io';

// import 'package:flutter/material.dart';

// import '../../pages/multipleImage.dart';
// import '../../pages/singleImage.dart';

//  void addFiles(List<File> files) async {
//     for (var i = 0; i < files.length; i++) {
//       animationWidgets.add(
//         SingleImage(

//           image:files[i].path,
//           perAnimation: perAnimation,
//           startZoomValue: perAnimationIntervalValue * i,
//           endZoomValue:
//               (perAnimationIntervalValue / 2) + (perAnimationIntervalValue * i),
//           startSlidingValue:
//               (perAnimationIntervalValue / 2) + (perAnimationIntervalValue * i),
//           endSlidingValue:
//               (perAnimationIntervalValue * i) + perAnimationIntervalValue,
//           key: Key('${i + 1}'),
//         ),
//       );
//     }
//   }