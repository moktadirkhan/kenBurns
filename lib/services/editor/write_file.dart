  import 'dart:io';

import 'dart:typed_data';

Future<File> writeFile(
      {required String location, required Uint8List bytes}) async {
    File file = File(location);
    return file.writeAsBytes(bytes);
  }
