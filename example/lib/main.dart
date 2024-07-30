import 'package:flutter/material.dart';
import 'package:voice_message_recorder/audio_encoder_type.dart';
import 'package:voice_message_recorder/recorderSize.dart';
import 'package:voice_message_recorder/screen/voice_message_recorder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RecorderSize().init(context);
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: SingleChatScreen(),
    );
  }
}

class SingleChatScreen extends StatelessWidget {
  const SingleChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          VoiceMessageRecorder(
            functionStartRecording: () {
              // function called when start recording
            },
            functionStopRecording: (time) {
              // function called when stop recording, return the recording time
            },
            functionSendVoice: (soundFile, time) {
              //  print("the current path is ${soundFile.path}");
            },
            encode: AudioEncoderType.AAC,
            functionRecorderStatus: (bool) {},
            functionSendTextMessage: (String text) {},
            functionDataCameraReceived: (String) {
              print(
                  "-VIDELCGVVDHCFCHGCDCHCDHCDHCDHCD    -$String-----------------------------------------------CAMERAA");
            },
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: RecorderSize.x20 / 2),
      ],
    );
  }
}
