class Util {
  static String formatDuration(Duration? d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = "$minute" + ":" + ((second < 10) ? "0$second" : "$second");
    return format;
  }
}
