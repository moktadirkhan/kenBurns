import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App());
}

// import 'package:flutter/material.dart';

// import 'package:vector_math/vector_math_64.dart' show Vector3;

// class HomePage extends StatefulWidget {
//   // final String image;
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   double _scale = 1.0;

//   late AnimationController controller;
//   late Animation zoomAnimation;
//   double _currentTranslationX = 0;
//   double _currentTranslationY = 0;
//   double _currentSliderValue = 0;
//   Duration animeDuration = const Duration(seconds: 10);
//   late Animation<double> currentx;
//   double currenty = 0.0;

//   @override
//   void initState() {
//     controller = AnimationController(
//       vsync: this,
//       duration: animeDuration,
//     );

//     zoomAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
//         parent: controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.linear))
//       ..addListener(() {
//         setState(() {
//           _scale = zoomAnimation.value;
//         });
//       }));

//     currentx = Tween(begin: 0.0, end: -180.0).animate(CurvedAnimation(
//         parent: controller,
//         curve: const Interval(0.5, 1.0, curve: Curves.linear))
//       ..addListener(() {
//         setState(() {
//           _currentTranslationX = currentx.value;
//         });
//       }));

//     super.initState();
//   }

//   String get timerString {
//     Duration duration = controller.duration! * controller.value;
//     return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }

//   String get totalDurationString {
//     Duration duration = controller.duration!;
//     return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             ClipRect(
//               child: Transform.translate(
//                 offset: Offset(_currentTranslationX, 1.0),
//                 child: Transform.scale(
//                   alignment: FractionalOffset.topLeft,
//                   scale: _scale,
//                   child: Image.network( "https://images.unsplash.com/photo-1578253809350-d493c964357f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Row(
//                 children: [
//                   Text("$timerString"),
//                   Spacer(),
//                   Text("$totalDurationString")
//                 ],
//               ),
//             ),
//             Slider(
//                 value: controller.value,
//                 label: _currentSliderValue.round().toString(),
//                 activeColor: Colors.blueAccent,
//                 inactiveColor: Colors.grey[700],
//                 onChanged: (double value) {
//                   setState(() {
//                     _currentSliderValue = value;
//                     controller.value = _currentSliderValue;
//                   });
//                 }),
//           ],
//         ),
//       ),
//       bottomSheet: Row(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               // _translationController!.forward();
//               controller.forward();
//               // _play();
//             },
//             child: const Text("Start"),
//           ),
//           Spacer(),
//           ElevatedButton(
//             onPressed: () {
//               controller.stop();
//             },
//             child: const Text("Stop"),
//           ),
//           Spacer(),
//           ElevatedButton(
//             onPressed: () {
//               controller.reset();
//             },
//             child: const Text("Reset"),
//           ),
//         ],
//       ),
//     );
//   }
// }


//       // onScaleStart: (ScaleStartDetails details) {
//             //   print(details);
//             //   _previousScale = _scale;
//             //   setState(() {});
//             // },
//             // onScaleUpdate: (ScaleUpdateDetails details) {
//             //   print(details);
//             //   _scale = _previousScale * details.scale;
//             //   setState(() {});
//             // },
//             // onScaleEnd: (ScaleEndDetails details) {
//             //   print(details);

//             //   _previousScale = 1.0;
//             //   setState(() {});
//             // },

                     

//             // Slider(
//             //     value: _currentSliderValue.toDouble(),
//             //     min: 1,
//             //     max: 8,
//             //     divisions: 7,
//             //     label: _currentSliderValue.round().toString(),
//             //     activeColor: Colors.white,
//             //     inactiveColor: Colors.grey[700],
//             //     onChanged: (double value) {
//             //       setState(() {
//             //         _currentSliderValue = value;
//             //         _scale = _currentSliderValue;
//             //         print("Scale $_scale");
//             //       });
//             //     }),

//             // ClipRect(
//             //    child: Transform(
//             //         alignment: FractionalOffset.topLeft,
//             //         // alignment: FractionalOffset.topLeft,
//             //         transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
//             //         child: Image.network(
//             //             "https://images.unsplash.com/photo-1578253809350-d493c964357f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
//             //       ),
//             //  ),
//           //    child: Column(
//           // children: [
//           //   ClipRect(
//           //     child: Transform.translate(
//           //       offset: Offset(_currentTranslationX, 1.0),
//           //       child: Transform.scale(
//           //         alignment: FractionalOffset.topLeft,
//           //         scale: _scale,
//           //         child: Image.network(widget.image),
//           //       ),
//           //     ),
//           //   ),
//           //   Container(
//           //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           //     child: Row(
//           //       children: [
//           //         Text("$timerString"),
//           //         Spacer(),
//           //         Text("$totalDurationString")
//           //       ],
//           //     ),
//           //   ),
//           //   Slider(
//           //       value: controller.value,
//           //       label: _currentSliderValue.round().toString(),
//           //       activeColor: Colors.blueAccent,
//           //       inactiveColor: Colors.grey[700],
//           //       onChanged: (double value) {
//           //         setState(() {
//           //           _currentSliderValue = value;
//           //           controller.value = _currentSliderValue;
//           //         });
//           //       }),
//           // ],