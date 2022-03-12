import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TemporaryFile {
  static Future<String> tmpFilePath() async {
    final Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final Directory filePath = Directory('${directory?.path}/videos');
    final Directory _appDocDirFolder =
        await filePath.create(recursive: true);
    return _appDocDirFolder.path;
  }

  static Future<void> deleteTmpFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  static Future<void> deleteDir() async {
    final dir = Directory(await tmpFilePath());
    dir.delete(recursive: true);
  }
}
