import 'package:flutter/material.dart';
import 'package:video_editor/domain/bloc/controller.dart';

String formatter(Duration duration) => [
      duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
      duration.inSeconds.remainder(60).toString().padLeft(2, '0')
    ].join(":");

Widget seekTime( VideoEditorController _controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: AnimatedBuilder(
      animation: _controller.video,
      builder: (_, __) {
        final duration = _controller.video.value.duration.inSeconds;
        final pos = _controller.trimPosition * duration;
        final start = _controller.minTrim * duration;
        final end = _controller.maxTrim * duration;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            children: [
              Text(formatter(Duration(seconds: pos.toInt())),
                  style: const TextStyle(color: Colors.white)),
              const Expanded(child: SizedBox()),
              AnimatedOpacity(
                opacity: !_controller.isPlaying ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(formatter(Duration(seconds: start.toInt())),
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  Text(formatter(Duration(seconds: end.toInt())),
                      style: const TextStyle(color: Colors.white)),
                ]),
              )
            ],
          ),
        );
      },
    ),
  );
}
