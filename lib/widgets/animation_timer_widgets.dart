import '../pages/multipleImage.dart';

String get timerString {
  Duration duration = controller!.duration! * controller!.value;
  return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
}

String get totalDurationString {
  Duration duration = controller!.duration!;
  return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
}
