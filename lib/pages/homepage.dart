import 'package:flutter/material.dart';
import 'package:image_zoom/pages/multipleImage.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class HomePage extends StatefulWidget {
  final String image;
  final Duration perAnimation;
  double startZoomValue;
  double endZoomValue;
  double startSlidingValue;
  double endSlidingValue;
  // double animationScale;
  HomePage({
    Key? key,
    required this.image,
    required this.perAnimation,
    required this.startZoomValue,
    required this.endZoomValue,
    required this.startSlidingValue,
    required this.endSlidingValue,

    // required this.animationScale
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double _scale = 1.0;
  late Animation zoomAnimation;
  double _currentTranslationX = 0;
  late Animation<double> currentx;
  double startValue = 0.125;
  double endValue = 0.25;
  double startTweenValue = 0.0;
  double endTweenValue = 0.0;

  // @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    zoomAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(widget.startZoomValue, widget.endZoomValue))
      ..addListener(() {
        if (mounted) {
          setState(() {
            _scale = zoomAnimation.value;
            // if (zoomAnimation.value == 1.5) {
            //   startValue = 0.25;
            //   endValue = 0.375;
            // }
          });
        }
      }));

    currentx = Tween(begin: 0.0, end: -160.0).animate(CurvedAnimation(
        parent: controller!,
        curve: Interval(widget.startSlidingValue, widget.endSlidingValue))
      ..addListener(() {
        if (mounted) {
          setState(() {
            _currentTranslationX = currentx.value;
          });
        }
      }));
    // controller!.forward();
    super.initState();
  }

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
    // print("animationScale $animationScale");
    // print("start $startValue");
    // print("end $endValue");

    return Container(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 500,
            child: ClipRect(
              child: Transform.translate(
                offset: Offset(_currentTranslationX, 1.0),
                child: Transform.scale(
                  alignment: FractionalOffset.topLeft,
                  scale: _scale,
                  child: Image.asset(widget.image),
                ),
              ),
            ),
          ),
          // Slider(
          //     value: controller!.value,
          //     label: _currentSliderValue.round().toString(),
          //     activeColor: Colors.blueAccent,
          //     inactiveColor: Colors.grey[700],
          //     onChanged: (double value) {
          //       setState(() {
          //         _currentSliderValue = value;
          //         animationScale = value;
          //         controller!.value = _currentSliderValue;
          //       });
          //     }),
        ],
      ),
    ));
  }
}


      // onScaleStart: (ScaleStartDetails details) {
            //   print(details);
            //   _previousScale = _scale;
            //   setState(() {});
            // },
            // onScaleUpdate: (ScaleUpdateDetails details) {
            //   print(details);
            //   _scale = _previousScale * details.scale;
            //   setState(() {});
            // },
            // onScaleEnd: (ScaleEndDetails details) {
            //   print(details);

            //   _previousScale = 1.0;
            //   setState(() {});
            // },

                     

            // Slider(
            //     value: _currentSliderValue.toDouble(),
            //     min: 1,
            //     max: 8,
            //     divisions: 7,
            //     label: _currentSliderValue.round().toString(),
            //     activeColor: Colors.white,
            //     inactiveColor: Colors.grey[700],
            //     onChanged: (double value) {
            //       setState(() {
            //         _currentSliderValue = value;
            //         _scale = _currentSliderValue;
            //         print("Scale $_scale");
            //       });
            //     }),

            // ClipRect(
            //    child: Transform(
            //         alignment: FractionalOffset.topLeft,
            //         // alignment: FractionalOffset.topLeft,
            //         transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
            //         child: Image.network(
            //             "https://images.unsplash.com/photo-1578253809350-d493c964357f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80"),
            //       ),
            //  ),
          //    child: Column(
          // children: [
          //   ClipRect(
          //     child: Transform.translate(
          //       offset: Offset(_currentTranslationX, 1.0),
          //       child: Transform.scale(
          //         alignment: FractionalOffset.topLeft,
          //         scale: _scale,
          //         child: Image.network(widget.image),
          //       ),
          //     ),
          //   ),
          //   Container(
          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     child: Row(
          //       children: [
          //         Text("$timerString"),
          //         Spacer(),
          //         Text("$totalDurationString")
          //       ],
          //     ),
          //   ),
          //   Slider(
          //       value: controller.value,
          //       label: _currentSliderValue.round().toString(),
          //       activeColor: Colors.blueAccent,
          //       inactiveColor: Colors.grey[700],
          //       onChanged: (double value) {
          //         setState(() {
          //           _currentSliderValue = value;
          //           controller.value = _currentSliderValue;
          //         });
          //       }),
          // ],