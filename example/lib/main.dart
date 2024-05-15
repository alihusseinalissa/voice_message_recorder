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
      home: SingleChatScreen(),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _isLoading = false;

  void _handleData(String data) {
    print("sdfsfsfsfsfsfsfsfsf#${data}");
    setState(() {
      _isLoading = true; // Show progress indicator
    });

    // Simulate data processing
    Future.delayed(Duration(seconds: 2), () {
      // After processing, hide progress indicator
      setState(() {
        _isLoading = false;
      });
      // Do something with the data
      print("Received data from child: $data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Widget'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show progress indicator
            : ChildWidget(onDataReceived: _handleData),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final Function(String) onDataReceived;

  ChildWidget({required this.onDataReceived});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Simulate getting data
        String data = "Some data";
        // Pass data back to parent
        onDataReceived(data);
      },
      child: Text('Send Data to Parent'),
    );
  }
}

class SingleChatScreen extends StatelessWidget {
  SingleChatScreen({
    Key? key,
  }) : super(key: key);

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
            functionStopRecording: (_time) {
              // function called when stop recording, return the recording time
            },
            functionSendVoice: (soundFile, _time) {
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
        SizedBox(width: MM.x20 / 2),
      ],
    );
  }
}
