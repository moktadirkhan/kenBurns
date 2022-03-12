import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_editor/domain/bloc/controller.dart';

import '../widgets/seekbar_widgets.dart';
import '../widgets/video_box.dart';

class VideoPreviewPage extends StatefulWidget {
  final VideoEditorController controller;
  const VideoPreviewPage({Key? key, required this.controller})
      : super(key: key);

  @override
  _VideoPreviewPageState createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  bool showGrid = false;
  String? _fileName;
  String? _directoryPath;
  String? _extension;

  String? filePath;
  File? audio;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  // void _pickAudio() async {
  //   try {
  //     _directoryPath = null;
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.audio,
  //       allowMultiple: false,
  //       onFileLoading: (FilePickerStatus status) => print(status),

  //     );
  //     setState(() {
  //       print("Identifier ${result!.files.single.name}");
  //       filePath = result.files.single.path!;
  //       _fileName = result.files.single.name;
  //       File(filePath!);
  //       // _fileName = (result.files.single.path!.split('/').last);
  //     });
  //     print("File name ${filePath}");
  //   } on PlatformException catch (e) {
  //     // _logException('Unsupported operation' + e.toString());
  //   } catch (e) {
  //     // _logException(e.toString());
  //   }
  //   if (!mounted) return;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Video Preview Page"),
        actions: [
          IconButton(
              onPressed: () {
                widget.controller.video.pause();
                // SaveVideo.savingDialog(context, widget.controller);
                // SaveVideo.saveWithFile(widget.controller.file, context);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 500,
            child: Stack(
              alignment: Alignment.center,
              children: videoBox(widget.controller, showGrid),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          seekbar(widget.controller),
          // ElevatedButton(
          //   onPressed: () => _pickAudio(),
          //   child: Text(
          //     _fileName == null ? "Pick Audio" : "$_fileName",
          //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () =>
          //       Execute(File(filePath!), widget.controller, context),
          //   child: Text("Execute"),
          // ),
        ],
      ),
    );
  }

//   void Execute(File? filePath, VideoEditorController controller,
//       BuildContext context) async {
//     File tmpFile = File("${await TemporaryFile.tmpFilePath()}/video_audio.mp4");
//     String command =
//         // "-i ${controller.file.path} -i $filePath -c:v copy -c:a copy ${tmpFile.path}";
//         "-i ${controller.file.path} -stream_loop -1 -i ${filePath!.path} -shortest -map 0:v:0 -map 1:a:0 -y ${tmpFile.path}";
//     FfmpegExecution.ffmpegExec(command, tmpFile.path, controller, context);
//   }
}
