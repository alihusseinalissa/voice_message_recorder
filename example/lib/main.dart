import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_recorder/audio_encoder_type.dart';
import 'package:voice_message_recorder/mySize.dart';
import 'package:voice_message_recorder/screen/voice_message_recorder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MM().init(context);
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: Spacing.only(top: 300, left: 4, right: 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: VoiceMessageRecorder(
                  // maxRecordTimeInSecond: 5,
                  startRecording: () {
                    // function called when start recording
                  },
                  stopRecording: (_time) {
                    // function called when stop recording, return the recording time
                  },
                  sendRequestFunction: (soundFile, _time) {
                    if (kDebugMode) {
                      print("@@@@@@@current path is ${soundFile.path}");
                    }
                  },
                  encode: AudioEncoderType.AAC,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
