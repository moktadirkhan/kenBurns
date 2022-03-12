// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_zoom/pages/multipleImage.dart';
// import 'package:vector_math/vector_math_64.dart' show Vector3;

// // ignore: must_be_immutable
// class SingleImage extends StatefulWidget {
//   final String image;
//   final Duration perAnimation;
//   double startZoomValue;
//   double endZoomValue;
//   double startSlidingValue;
//   double endSlidingValue;
//   SingleImage({
//     Key? key,
//     required this.image,
//     required this.perAnimation,
//     required this.startZoomValue,
//     required this.endZoomValue,
//     required this.startSlidingValue,
//     required this.endSlidingValue,
//   }) : super(key: key);

//   @override
//   _SingleImageState createState() => _SingleImageState();
// }

// class _SingleImageState extends State<SingleImage>
//     with TickerProviderStateMixin {
//   double _scale = 1.0;
//   late Animation zoomAnimation;
//   double _currentTranslationX = 0;
//   late Animation<double> currentx;

//   @override
//   void initState() {
//     zoomAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
//         parent: controller!,
//         curve: Interval(widget.startZoomValue, widget.endZoomValue))
//       ..addListener(() {
//         if (mounted) {
//           setState(() {
//             _scale = zoomAnimation.value;
//           });
//         }
//       }));

//     currentx = Tween(begin: 0.0, end: -160.0).animate(CurvedAnimation(
//         parent: controller!,
//         curve: Interval(widget.startSlidingValue, widget.endSlidingValue))
//       ..addListener(() {
//         if (mounted) {
//           setState(() {
//             _currentTranslationX = currentx.value;
//           });
//         }
//       }));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 500,
//                 child: ClipRect(
//                   child: Transform.translate(
//                     offset: Offset(_currentTranslationX, 1.0),
//                     child: Transform.scale(
//                       alignment: FractionalOffset.topLeft,
//                       scale: _scale,
//                       child: Image.file(File(widget.image)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
