import 'package:flutter/material.dart';
import 'package:voice_message_recorder/audio_encoder_type.dart';
import 'package:voice_message_recorder/mySize.dart';
import 'package:voice_message_recorder/screen/voice_message_recorder.dart';

import 'myColors.dart';

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

class SingleChatScreen extends StatelessWidget {
  SingleChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChatInputField(),
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

class ChatInputField extends StatefulWidget {
  ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController message = TextEditingController();

  bool swap = true;
  bool switchTextVoice = true;
  double containerHeight = MM.x60; // Initial height of the container
  final FocusNode textInputFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    print(
        "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN         $switchTextVoice   dddddddddddddddddddddddddddddddddddddddd");

    return Container(
      // Use AnimatedContainer
      // duration: Duration(milliseconds: 300), // Animation duration
      height: containerHeight, // Set container height

      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MM.x5,
            ),
            if (switchTextVoice)
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MM.x20 * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: MK.white,
                    border: Border.all(color: MK.grey),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: MK.primary,
                      ),
                      SizedBox(width: MM.x10),
                      Expanded(
                        child: TextField(
                          focusNode: textInputFocus,
                          controller: message,
                          onChanged: (val) {
                            setState(() {
                              if (message.text.isNotEmpty) {
                                swap = false;
                                containerHeight =
                                    MM.x90; // Reset container height
                              } else {
                                swap = true;
                                containerHeight =
                                    MM.x60; // Increase container height
                              }
                            });
                          },
                          maxLines: 3, // Limit to 3 lines
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                              color: MK.primary,
                            ),
                            hintText: "Type message",
                            labelStyle: TextStyle(
                              color: MK.primary,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.attach_file,
                        color: MK.primary,
                      ),
                      SizedBox(width: MM.x10),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: MK.primary,
                      ),
                    ],
                  ),
                ),
              ),
            Align(
                alignment: Alignment.centerLeft,
                child: swap
                    ? VoiceMessageRecorder(
                        startRecording: () {
                          print("---------------------------------------");
                          textInputFocus.unfocus();

                          // function called when start recording
                        },
                        stopRecording: (_time) {
                          // function called when stop recording, return the recording time
                        },
                        sendRequestFunction: (soundFile, _time) {
                          //  print("the current path is ${soundFile.path}");
                        },
                        encode: AudioEncoderType.AAC,
                        recorderStatus: (bool) {
                          switchTextVoice = bool;

                          print(
                              "******mmm***************$switchTextVoice   $bool     ****************************************");
                        },
                      )
                    : Padding(
                        padding: Spacing.only(left: MM.x12, right: MM.x10),
                        child: InkWell(
                          onTap: () async {},
                          child: Transform.scale(
                            scale: 1.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(MM.x600),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                                width: MM.x45,
                                height: MM.x45,
                                child: Container(
                                  color: MK.primary,
                                  child: Padding(
                                    padding: Spacing.all(MM.x4),
                                    child: Icon(
                                      Icons.send,
                                      textDirection: TextDirection.ltr,
                                      size: MM.x26,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
            /* GFButton(
              shape: GFButtonShape.standard,
              type: GFButtonType.outline,
              onPressed: () {},
              icon: Icon(Icons.send),
            )*/
          ],
        ),
      ),
    );
  }
}
