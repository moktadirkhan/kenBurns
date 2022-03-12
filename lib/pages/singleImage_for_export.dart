import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_zoom/pages/multipleImage.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

// ignore: must_be_immutable
class SingleImageForExport extends StatefulWidget {
  AnimationController animationController;
  final String image;
  final GlobalKey globalKey;
  SingleImageForExport({
    Key? key,
    required this.animationController,
    required this.image,
    required this.globalKey,
  }) : super(key: key);

  @override
  _SingleImageState createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImageForExport>
    with TickerProviderStateMixin {
  double _scale1 = 1.0;
  late Animation zoomAnimation1;
  double _currentTranslationX1 = 0;
  late Animation<double> currentx1;

  @override
  void initState() {
    zoomAnimation1 = Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(
            parent: widget.animationController, curve: Interval(0.0, 0.5))
          ..addListener(() {
            if (mounted) {
              setState(() {
                _scale1 = zoomAnimation1.value;
              });
            }
          }));

    currentx1 = Tween(begin: 0.0, end: -160.0).animate(CurvedAnimation(
        parent: widget.animationController, curve: Interval(0.5, 1.0))
      ..addListener(() {
        if (mounted) {
          setState(() {
            _currentTranslationX1 = currentx1.value;
          });
        }
      }));

    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: widget.globalKey,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: ClipRect(
                  child: Transform.translate(
                    offset: Offset(_currentTranslationX1, 1.0),
                    child: Transform.scale(
                      alignment: FractionalOffset.topLeft,
                      scale: _scale1,
                      child: Image.file(File(widget.image)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
