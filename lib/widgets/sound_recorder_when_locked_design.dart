library voice_message_recorder;

import 'package:flutter/material.dart';
import 'package:voice_message_recorder/provider/sound_record_notifier.dart';
import 'package:voice_message_recorder/widgets/show_counter.dart';

import '../mySize.dart';

// ignore: must_be_immutable
class SoundRecorderWhenLockedDesign extends StatelessWidget {
  final double fullRecordPackageHeight;
  final SoundRecordNotifier soundRecordNotifier;
  final String? cancelText;
  final Function sendRequestFunction;
  final Function(String time)? stopRecording;
  final Widget? recordIconWhenLockedRecord;
  final TextStyle? cancelTextStyle;
  final TextStyle? counterTextStyle;
  final Color sendButtonBackgroundColor;
  final Color? counterBackGroundColor;
  final Color? cancelTextBackGroundColor;
  final Widget? sendButtonIcon;
  // ignore: sort_constructors_first
  const SoundRecorderWhenLockedDesign({
    Key? key,
    required this.fullRecordPackageHeight,
    required this.sendButtonIcon,
    required this.soundRecordNotifier,
    required this.cancelText,
    required this.sendRequestFunction,
    this.stopRecording,
    required this.recordIconWhenLockedRecord,
    required this.cancelTextStyle,
    required this.counterTextStyle,
    required this.sendButtonBackgroundColor,
    required this.counterBackGroundColor,
    required this.cancelTextBackGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: cancelTextBackGroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(MM.x24),
          topRight: Radius.circular(MM.x24),
        ),
      ),
      child: InkWell(
        onTap: () {
          soundRecordNotifier.isShow = false;
          soundRecordNotifier.resetEdgePadding();
        },
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                soundRecordNotifier.isShow = false;
                soundRecordNotifier.finishRecording();
              },
              child: Transform.scale(
                scale: 1.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(MM.x600),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    width: fullRecordPackageHeight,
                    height: fullRecordPackageHeight,
                    child: Container(
                      color: sendButtonBackgroundColor,
                      child: Padding(
                        padding: Spacing.all(MM.x4),
                        child: recordIconWhenLockedRecord ??
                            sendButtonIcon ??
                            Icon(
                              Icons.send,
                              textDirection: TextDirection.ltr,
                              size: MM.x28,
                              color: (soundRecordNotifier.buttonPressed)
                                  ? Colors.grey.shade200
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                  onTap: () {
                    soundRecordNotifier.isShow = false;
                    String _time = soundRecordNotifier.minute.toString() +
                        ":" +
                        soundRecordNotifier.second.toString();
                    if (stopRecording != null) stopRecording!(_time);
                    soundRecordNotifier.resetEdgePadding();
                  },
                  child: Padding(
                    padding: Spacing.all(MM.x8),
                    child: Text(
                      cancelText ?? "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: cancelTextStyle ??
                          const TextStyle(
                            color: Colors.black,
                          ),
                    ),
                  )),
            ),
            ShowCounter(
              soundRecorderState: soundRecordNotifier,
              counterTextStyle: counterTextStyle,
              counterBackGroundColor: counterBackGroundColor,
              fullRecordPackageHeight: fullRecordPackageHeight,
            ),
          ],
        ),
      ),
    );
  }
}
