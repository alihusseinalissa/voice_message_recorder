library voice_message_recorder;

import 'package:flutter/material.dart';
import 'package:voice_message_recorder/mySize.dart';
import 'package:voice_message_recorder/voice_message_recorder/provider/sound_record_notifier.dart';

/// Used this class to show counter and mic Icon
class ShowCounter extends StatelessWidget {
  final SoundRecordNotifier soundRecorderState;
  final TextStyle? counterTextStyle;
  final Color? counterBackGroundColor;
  final double fullRecordPackageHeight;
  // ignore: sort_constructors_first
  const ShowCounter({
    required this.soundRecorderState,
    required this.fullRecordPackageHeight,
    super.key,
    this.counterTextStyle,
    required this.counterBackGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: counterBackGroundColor ?? const Color(0xfff5f4f4),
            borderRadius: BorderRadius.all(Radius.circular(MM.x30))),
        height: fullRecordPackageHeight * 0.98,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: Spacing.only(top: MM.x6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MM.x30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    soundRecorderState.second.toString().padLeft(2, '0'),
                    style: counterTextStyle ??
                        const TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: MM.x3),
                  const Text(" : "),
                  Text(
                    soundRecorderState.minute.toString().padLeft(2, '0'),
                    style: counterTextStyle ??
                        const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(width: MM.x3),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: soundRecorderState.second % 2 == 0 ? 1 : 0,
                child: const Icon(
                  Icons.mic,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: MM.x10),
            ],
          ),
        ),
      ),
    );
  }
}
