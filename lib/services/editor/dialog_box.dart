
  import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

Future<void> dialogBox(ProgressDialog pd, int value) async {
    pd.show(
      max: 100,
      msg: "Preparing Video",
      progressType: ProgressType.valuable,
      backgroundColor: Color(0xff212121),
      progressValueColor: Color(0xff3550B4),
      progressBgColor: Colors.white70,
      msgColor: Colors.white,
      valueColor: Colors.white,
    );
    pd.update(value: value);
  }