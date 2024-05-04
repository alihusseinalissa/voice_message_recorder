library voice_message_recorder;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_recorder/provider/sound_record_notifier.dart';

import '../mySize.dart';

/// used to show mic and show dragg text when
/// press into record icon
class ShowMicWithText extends StatelessWidget {
  final bool shouldShowText;
  final String? slideToCancelText;
  final SoundRecordNotifier soundRecorderState;
  final TextStyle? slideToCancelTextStyle;
  final Color? backGroundColor;
  final Widget? recordIcon;
  final Color? counterBackGroundColor;
  final double fullRecordPackageHeight;
  final double initRecordPackageWidth;

  // ignore: sort_constructors_first
  ShowMicWithText({
    required this.backGroundColor,
    required this.initRecordPackageWidth,
    required this.fullRecordPackageHeight,
    Key? key,
    required this.shouldShowText,
    required this.soundRecorderState,
    required this.slideToCancelTextStyle,
    required this.slideToCancelText,
    required this.recordIcon,
    required this.counterBackGroundColor,
  }) : super(key: key);
  final colorizeColors = [
    Colors.black,
    Colors.grey.shade200,
    Colors.black,
  ];
  final colorizeTextStyle = TextStyle(
    fontSize: MM.x14,
    fontFamily: 'Horizon',
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !soundRecorderState.buttonPressed
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              key: soundRecorderState.key,
              scale: soundRecorderState.buttonPressed ? 1.3 : 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(MM.x600),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  width: soundRecorderState.buttonPressed
                      ? fullRecordPackageHeight
                      : initRecordPackageWidth - 5,
                  height: fullRecordPackageHeight,
                  child: Container(
                    color: (soundRecorderState.buttonPressed)
                        ? backGroundColor ??
                            Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    child: Padding(
                      padding: Spacing.all(MM.x4),
                      child: recordIcon ??
                          Icon(
                            Icons.mic,
                            size: 28,
                            color: (soundRecorderState.buttonPressed)
                                ? Colors.grey.shade200
                                : Colors.black,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (shouldShowText)
          Expanded(
            child: Padding(
              padding: Spacing.only(left: MM.x8, right: MM.x8),
              child: DefaultTextStyle(
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: TextStyle(
                  fontSize: MM.x15,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      slideToCancelText ?? "",
                      textStyle: slideToCancelTextStyle ?? colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {},
                ),
              ),
            ),
          ),
      ],
    );
  }
}
