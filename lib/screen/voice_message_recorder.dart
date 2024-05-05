library voice_message_recorder;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_message_recorder/provider/sound_record_notifier.dart';
import 'package:voice_message_recorder/widgets/lock_record.dart';
import 'package:voice_message_recorder/widgets/show_counter.dart';
import 'package:voice_message_recorder/widgets/show_mic_with_text.dart';
import 'package:voice_message_recorder/widgets/sound_recorder_when_locked_design.dart';

import '../audio_encoder_type.dart';
import '../mySize.dart';

class VoiceMessageRecorder extends StatefulWidget {
  /// use it for change back ground of cancel
  final Color? cancelTextBackGroundColor;

  /// function return the recording sound file and the time
  final Function(File soundFile, String time) sendRequestFunction;

  /// function called when start recording
  final Function()? startRecording;

  /// function called when stop recording, return the recording time (even if time < 1)
  final Function(String time)? stopRecording;

  /// recording Icon That pressesd to start record
  final Widget? recordIcon;

  /// recording Icon when user locked the record
  final Widget? recordIconWhenLockedRecord;

  /// use to change the backGround Icon when user recording sound
  final Color? recordIconBackGroundColor;

  /// use to change the Icon backGround color when user locked the record
  final Color? sendButtonBackgroundColor;

  /// use to change all recording widget color
  final Color? backGroundColor;

  /// use to change the counter style
  final TextStyle? timerTextStyle;

  /// text to know user should drag in the left to cancel record
  final String? slideToCancelText;

  /// use to change slide to cancel textstyle
  final TextStyle? slideToCancelTextStyle;

  /// this text show when lock record and to tell user should press in this text to cancel recod
  final String? cancelText;

  /// use to change cancel text style
  final TextStyle? cancelTextStyle;

  /// put you file directory storage path if you didn't pass it take deafult path
  final String? storeSoundRecoringPath;

  /// Chose the encode type
  final AudioEncoderType encode;

  /// use if you want change the raduis of un record
  final BorderRadius? radius;

  // use to change the counter back ground color
  final Color? timerBackgroundColor;
  final Color? backGroundBoarderColor;

  final double? boarderRadius;
  // use to change lock icon to design you need it
  final Widget? lockButton;

  // use it to change send button when user lock the record
  final Widget? sendButtonIcon;

  // this function called when cancel record function

  // use to set max record time in second
  final int? maxRecordTimeInSecond;

  // use to change full package Height
  final double fullRecordPackageHeight;

  final double initRecordPackageWidth;
  final double? horizontalPadding;
  // ignore: sort_constructors_first
  const VoiceMessageRecorder({
    this.sendButtonIcon,
    this.initRecordPackageWidth = 50,
    this.fullRecordPackageHeight = 50,
    this.maxRecordTimeInSecond,
    this.storeSoundRecoringPath = "",
    required this.sendRequestFunction,
    this.startRecording,
    this.stopRecording,
    this.recordIcon,
    this.lockButton,
    this.timerBackgroundColor,
    this.recordIconWhenLockedRecord,
    this.recordIconBackGroundColor = const Color(0xff01a801),
    this.sendButtonBackgroundColor = const Color(0xff01a801),
    this.backGroundColor = const Color(0xfff5f4f4),
    this.backGroundBoarderColor = const Color(0xffd5d4d4),
    this.cancelTextStyle,
    this.timerTextStyle,
    this.slideToCancelTextStyle,
    this.slideToCancelText = " Slide to Cancel >",
    this.cancelText = "Cancel",
    this.encode = AudioEncoderType.AAC,
    this.cancelTextBackGroundColor,
    this.radius,
    Key? key,
    this.boarderRadius = 30,
    this.horizontalPadding = 5,
  }) : super(key: key);

  @override
  _SocialMediaRecorder createState() => _SocialMediaRecorder();
}

class _SocialMediaRecorder extends State<VoiceMessageRecorder> {
  late SoundRecordNotifier soundRecordNotifier;

  @override
  void initState() {
    soundRecordNotifier = SoundRecordNotifier(
      maxRecordTime: widget.maxRecordTimeInSecond,
      startRecording: widget.startRecording ?? () {},
      stopRecording: widget.stopRecording ?? (String x) {},
      sendRequestFunction: widget.sendRequestFunction,
    );

    soundRecordNotifier.initialStorePathRecord =
        widget.storeSoundRecoringPath ?? "";
    soundRecordNotifier.isShow = false;
    soundRecordNotifier.voidInitialSound();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MM().init(context);
    soundRecordNotifier.maxRecordTime = widget.maxRecordTimeInSecond;
    soundRecordNotifier.startRecording = widget.startRecording ?? () {};
    soundRecordNotifier.stopRecording = widget.stopRecording ?? (String x) {};
    soundRecordNotifier.sendRequestFunction = widget.sendRequestFunction;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => soundRecordNotifier),
        ],
        child: Consumer<SoundRecordNotifier>(
          builder: (context, value, _) {
            return Padding(
              padding: Spacing.symmetric(horizontal: widget.horizontalPadding!),
              child: Directionality(
                  textDirection: TextDirection.rtl, child: makeBody(value)),
            );
          },
        ));
  }

  Widget makeBody(SoundRecordNotifier state) {
    return Column(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (scrollEnd) {
            state.updateScrollValue(scrollEnd.globalPosition, context);
          },
          onHorizontalDragEnd: (x) {
            if (state.buttonPressed && !state.isLocked) state.finishRecording();
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: recordVoice(state),
          ),
        )
      ],
    );
  }

  Widget recordVoice(SoundRecordNotifier state) {
    if (state.lockScreenRecord == true) {
      return SoundRecorderWhenLockedDesign(
          cancelText: widget.cancelText,
          fullRecordPackageHeight: widget.fullRecordPackageHeight,
          // cancelRecordFunction: widget.cacnelRecording ?? () {},
          sendButtonIcon: widget.sendButtonIcon,
          lockRecordingBackGroundColor: widget.cancelTextBackGroundColor,
          cancelTextStyle: widget.cancelTextStyle,
          counterBackGroundColor: widget.timerBackgroundColor,
          sendButtonBackgroundColor:
              widget.sendButtonBackgroundColor ?? Colors.blue,
          counterTextStyle: widget.timerTextStyle,
          recordIconWhenLockedRecord: widget.recordIconWhenLockedRecord,
          sendRequestFunction: widget.sendRequestFunction,
          soundRecordNotifier: state,
          stopRecording: widget.stopRecording,
          boarderRadius: widget.boarderRadius!,
          backGroundBoarderColor: widget.backGroundBoarderColor);
    }

    return Listener(
      onPointerDown: (details) async {
        state.setNewInitialDraggableHeight(details.position.dy);
        state.resetEdgePadding();

        soundRecordNotifier.isShow = true;
        state.record(widget.startRecording);
      },
      onPointerUp: (details) async {
        if (!state.isLocked) {
          state.finishRecording();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: soundRecordNotifier.isShow ? 0 : 300),
        height: widget.fullRecordPackageHeight,
        width: (soundRecordNotifier.isShow)
            ? MediaQuery.of(context).size.width
            : widget.initRecordPackageWidth,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: Spacing.only(right: state.edge),
                child: Container(
                  decoration: BoxDecoration(
                    border: soundRecordNotifier.isShow
                        ? Border(
                            top: BorderSide(
                                color: widget.backGroundBoarderColor!),
                            bottom: BorderSide(
                                color: widget.backGroundBoarderColor!),
                            left: BorderSide(
                                color: widget.backGroundBoarderColor!))
                        : Border.all(color: Colors.transparent),
                    borderRadius: soundRecordNotifier.isShow
                        ? BorderRadius.only(
                            topLeft: Radius.circular(widget.boarderRadius!),
                            bottomLeft: Radius.circular(widget.boarderRadius!),
                            topRight: Radius.circular(widget.boarderRadius!),
                            bottomRight: Radius.circular(widget.boarderRadius!))
                        : widget.radius != null && !soundRecordNotifier.isShow
                            ? widget.radius
                            : BorderRadius.circular(0),
                    color: (soundRecordNotifier.isShow)
                        ? widget.backGroundColor
                        : Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: ShowMicWithText(
                          initRecordPackageWidth: widget.initRecordPackageWidth,
                          counterBackGroundColor: widget.timerBackgroundColor,
                          recordButtonBackGroundColor:
                              widget.recordIconBackGroundColor,
                          fullRecordPackageHeight:
                              widget.fullRecordPackageHeight,
                          recordIcon: widget.recordIcon,
                          shouldShowText: soundRecordNotifier.isShow,
                          soundRecorderState: state,
                          slideToCancelTextStyle: widget.slideToCancelTextStyle,
                          slideToCancelText: widget.slideToCancelText,
                        ),
                      ),
                      if (soundRecordNotifier.isShow)
                        Center(
                          child: ShowCounter(
                              counterBackGroundColor:
                                  widget.timerBackgroundColor,
                              soundRecorderState: state,
                              fullRecordPackageHeight:
                                  widget.fullRecordPackageHeight),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MM.x70,
              child: LockRecord(
                soundRecorderState: state,
                lockIcon: widget.lockButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
