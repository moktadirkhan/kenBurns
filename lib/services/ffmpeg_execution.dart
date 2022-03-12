import 'dart:io';

import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:image_zoom/services/temporary_file_path.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:video_editor/domain/bloc/controller.dart';

import '../router.dart';

class FfmpegExecution {
  void runFFmpeg(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);

    VideoEditorController? videoController;
    File tmpFile =
        File("${await TemporaryFile.tmpFilePath()}/videoKenBurn.mp4");
    int framerate = 25;
    var location = await TemporaryFile.tmpFilePath();
    TemporaryFile.deleteTmpFile(tmpFile);

    String command =
        "-r $framerate -start_number 1 -i $location/frame_%d.png -an -c:v libx264 -preset medium -crf 10 -tune animation -preset medium -pix_fmt yuv420p -vf pad=ceil(iw/2)*2:ceil(ih/2)*2 ${tmpFile.path}";
    FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        // SUCCESS'
        videoController = VideoEditorController.file(File(tmpFile.path))
          ..initialize();
        pd.close();
        openVideoPreviewPage(context, videoController!);
        print("KenBurns success");
      } else if (ReturnCode.isCancel(returnCode)) {
        // CANCEL

        print("KenBurns cancelled");
      } else {
        // ERROR

        print("KenBurns error");
      }
    });
  }
}
