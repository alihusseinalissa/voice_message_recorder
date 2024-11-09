library voice_message_recorder;

import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:voice_message_recorder/provider/sound_record_notifier.dart';
import 'package:voice_message_recorder/widgets/lock_record.dart';
import 'package:voice_message_recorder/widgets/show_counter.dart';
import 'package:voice_message_recorder/widgets/show_mic_with_text.dart';
import 'package:voice_message_recorder/widgets/sound_recorder_when_locked_design.dart';

import '../audio_encoder_type.dart';
import '../recorderSize.dart';
import 'camera/CameraView.dart';
import 'camera/VideoView.dart';
import 'camera/camera.dart';
import 'filePicker.dart';

class VoiceMessageRecorder extends StatefulWidget {
  /// use it for change back ground of cancel
  final Color? cancelTextBackGroundColor;

  /// function return the recording sound file and the time
  final Function(File soundFile, String time) functionSendVoice;

  /// function called when start recording
  final Function()? functionStartRecording;

  /// function called when stop recording, return the recording time (even if time < 1)
  final Function(String time)? functionStopRecording;
  final Function(bool) functionRecorderStatus;
  final Function(String camera)? functionCameraPicker;
  final Function(String file)? functionFilePicker;
  final Function(String emogi)? functionEmogiPicker;
  final Function(String text) functionSendTextMessage;
  final Function(String) functionDataCameraReceived;

  /// recording Icon That pressesd to start record
  final Widget? recordIcon;

  /// recording Icon when user locked the record
  final Widget? recordIconWhenLockedRecord;

  /// use to change the backGround Icon when user recording sound
  final Color? recordIconBackGroundColor;

  /// use to change the Icon backGround color when user locked the record
  final Color? sendButtonBackgroundColor;

  /// use to change all recording widget color
  final Color? textFieldBackGroundColor;
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
  final double? verticalPadding;
  // ignore: sort_constructors_first
  const VoiceMessageRecorder({
    this.sendButtonIcon,
    this.initRecordPackageWidth = 50,
    this.fullRecordPackageHeight = 50,
    this.maxRecordTimeInSecond,
    this.storeSoundRecoringPath = "",
    required this.functionSendVoice,
    this.functionStartRecording,
    this.functionStopRecording,
    this.recordIcon,
    this.lockButton,
    this.timerBackgroundColor,
    this.recordIconWhenLockedRecord,
    this.recordIconBackGroundColor = const Color(0xFF128C7E),
    this.sendButtonBackgroundColor = const Color(0xFF128C7E),
    this.textFieldBackGroundColor = const Color(0xffffffff),
    this.backGroundBoarderColor = const Color(0xffffffff),
    this.backGroundColor = const Color(0xffd7d7d7),
    this.cancelTextStyle,
    this.timerTextStyle,
    this.slideToCancelTextStyle,
    this.slideToCancelText = " Slide to Cancel >",
    this.cancelText = "Cancel",
    this.encode = AudioEncoderType.AAC,
    this.cancelTextBackGroundColor = const Color(0xfffaefef),
    this.radius,
    super.key,
    this.boarderRadius = 30,
    this.verticalPadding = 5,
    required this.functionRecorderStatus,
    this.functionCameraPicker,
    this.functionFilePicker,
    this.functionEmogiPicker,
    required this.functionSendTextMessage,
    required this.functionDataCameraReceived,
  });

  @override
  _VoiceMessageRecorder createState() => _VoiceMessageRecorder();
}

class _VoiceMessageRecorder extends State<VoiceMessageRecorder> {
  late SoundRecordNotifier soundRecordNotifier;
  final FlutterNativeContactPicker _contactPicker = FlutterNativeContactPicker();
  List<Contact>? _contacts;
  @override
  void initState() {
    soundRecordNotifier = SoundRecordNotifier(
      maxRecordTime: widget.maxRecordTimeInSecond,
      startRecording: widget.functionStartRecording ?? () {},
      stopRecording: widget.functionStopRecording ?? (String x) {},
      sendRequestFunction: widget.functionSendVoice,
    );

    soundRecordNotifier.initialStorePathRecord =
        widget.storeSoundRecoringPath ?? "";
    soundRecordNotifier.isShow = false;
    soundRecordNotifier.voidInitialSound();
    super.initState();
  }

  @override
  void dispose() {
    textInputFocus.dispose();
    message.dispose();
    super.dispose();
  }

  TextEditingController message = TextEditingController();

  bool switchTextVoice = true;
  // Initial height of the container
  final FocusNode textInputFocus = FocusNode();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    RecorderSize().init(context);
    soundRecordNotifier.maxRecordTime = widget.maxRecordTimeInSecond;
    soundRecordNotifier.startRecording = widget.functionStartRecording ?? () {};
    soundRecordNotifier.stopRecording =
        widget.functionStopRecording ?? (String x) {};
    soundRecordNotifier.sendRequestFunction = widget.functionSendVoice;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CameraState()),
          ChangeNotifierProvider(create: (context) => soundRecordNotifier),
        ],
        child: Consumer<SoundRecordNotifier>(
          builder: (context, value, _) {
            return Directionality(
                textDirection: TextDirection.rtl, child: makeBody(value));
          },
        ));
  }

  Widget makeBody(SoundRecordNotifier state) {
    if (soundRecordNotifier.buttonPressed == false &&
        soundRecordNotifier.isLocked == false &&
        soundRecordNotifier.isShow == false &&
        soundRecordNotifier.lockScreenRecord == false) {
      widget.functionRecorderStatus(true);
    } else {
      widget.functionRecorderStatus(false);
    }

    return Container(
      decoration: BoxDecoration(color: widget.backGroundColor),
      padding: Spacing.symmetric(vertical: widget.verticalPadding!),
      child: Column(
        children: [
          Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: message.text.isEmpty
                      ? GestureDetector(
                          onHorizontalDragUpdate: (scrollEnd) {
                            state.updateScrollValue(
                                scrollEnd.globalPosition, context);
                          },
                          onHorizontalDragEnd: (x) {
                            if (state.buttonPressed && !state.isLocked) {
                              state.finishRecording();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(widget.boarderRadius!),
                                topRight:
                                    Radius.circular(widget.boarderRadius!),
                              ),
                            ),
                            child: recordVoice(state),
                          ),
                        )
                      : Padding(
                          padding: Spacing.only(
                              left: RecorderSize.x10, right: RecorderSize.x10),
                          child: InkWell(
                            onTap: () {
                              widget.functionSendTextMessage(message.text);
                              message.clear();
                              setState(() {});
                            },
                            child: Transform.scale(
                              scale: 1.2,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(RecorderSize.x600),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                  width: RecorderSize.x42,
                                  height: RecorderSize.x42,
                                  child: Container(
                                    color: widget.sendButtonBackgroundColor,
                                    child: Padding(
                                      padding: Spacing.all(RecorderSize.x4),
                                      child: Icon(
                                        Icons.send,
                                        textDirection: TextDirection.ltr,
                                        size: RecorderSize.x26,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
              if (!soundRecordNotifier.isShow)
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: message.text.length > 90
                      ? RecorderSize.x130
                      : message.text.length > 69
                          ? RecorderSize.x110
                          : message.text.length > 48
                              ? RecorderSize.x100
                              : message.text.length > 23
                                  ? RecorderSize.x80
                                  : widget.fullRecordPackageHeight,
                  padding: EdgeInsets.symmetric(
                    horizontal: RecorderSize.x20 * 0.50,
                  ),
                  decoration: BoxDecoration(
                    color: widget.textFieldBackGroundColor,
                    border: Border.all(color: const Color(0xFFEFEFEF)),
                    borderRadius: BorderRadius.circular(message.text.length > 23
                        ? RecorderSize.x18
                        : widget.boarderRadius!),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (builder) => bottomSheet());
                        },
                        child: const Icon(
                          Icons.attach_file,
                          color: Colors.black,
                        ),
                      ),
                      if (message.text.isEmpty)
                        SizedBox(width: RecorderSize.x10),
                      if (message.text.isEmpty)
                        GestureDetector(
                          onTap: () {
                            _checkPermissionAndOpenCamera();
                          },
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextField(
                            textDirection: TextDirection.ltr,
                            focusNode: textInputFocus,
                            controller: message,
                            onTap: () {
                              show = false;
                              setState(() {});
                            },
                            onChanged: (val) {
                              show = false;
                              setState(() {});
                            },
                            maxLines: 4, // Limit to 3 lines
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: message.text.isEmpty
                                      ? RecorderSize.x12
                                      : RecorderSize.x1,
                                  bottom: RecorderSize.x1),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              hintText: "Type message ...",
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: RecorderSize.x3,
                      ),
                      GestureDetector(
                        child: Icon(
                          show ? Icons.keyboard : Icons.emoji_emotions_outlined,
                        ),
                        onTap: () {
                          if (!show) {
                            textInputFocus.unfocus();
                            textInputFocus.canRequestFocus = false;
                          }
                          setState(() {
                            show = !show;
                          });
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
          show ? emojiSelect() : Container(),
        ],
      ),
    );
  }

  void _checkPermissionAndOpenCamera() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        // Handle denied permissions
        return;
      }
    }
    _openCamera();
  }

  void _openCamera() {
    textInputFocus.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          IconBackGroundColor: widget.recordIconBackGroundColor!,
          onDataCameraReceived: widget.functionDataCameraReceived,
          onDataVideoReceived: widget.functionDataCameraReceived,
        ),
      ),
    );
  }

  Widget recordVoice(SoundRecordNotifier state) {
    if (kDebugMode) {
      print(
          "YYYYYYYYYYYYY state.lockScreenRecord    ${state.lockScreenRecord}            YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
    }
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
          sendRequestFunction: widget.functionSendVoice,
          soundRecordNotifier: state,
          stopRecording: widget.functionStopRecording,
          boarderRadius: widget.boarderRadius!,
          backGroundBoarderColor: widget.backGroundBoarderColor);
    }

    return Listener(
      onPointerDown: (details) async {
        state.setNewInitialDraggableHeight(details.position.dy);
        state.resetEdgePadding();

        soundRecordNotifier.isShow = true;
        state.record(widget.functionStartRecording);
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
            ? MediaQuery.of(context).size.width * 0.99
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
                        ? widget.textFieldBackGroundColor
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
              width: RecorderSize.x70,
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

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: RecorderSize.x10, vertical: RecorderSize.x20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icons: Icons.insert_drive_file,
                      color: Colors.indigo,
                      text: 'Document',
                      onTap: () {
                        pickFile(extension: [
                          'doc',
                          'pdf',
                          'docx',
                          'txt',
                          'rtf',
                          'odt',
                          'zip',
                          'rar',
                          'tar',
                          'gz',
                          '7z',
                          'exe',
                          'apk',
                          'app',
                          'msi',
                          'xml',
                          'json',
                          'csv',
                          'sql',
                          'css'
                        ]);
                      }),
                  SizedBox(
                    width: RecorderSize.x40,
                  ),
                  iconCreation(
                      icons: Icons.video_collection_outlined,
                      color: Colors.pink,
                      text: 'Video',
                      onTap: () {
                        pickFile(extension: [
                          'mp4',
                          'avi',
                          'mov',
                          'vmv',
                          'flv',
                        ]);
                      }),
                  SizedBox(
                    width: RecorderSize.x40,
                  ),
                  iconCreation(
                      icons: Icons.insert_photo,
                      color: Colors.purple,
                      text: 'Gallery',
                      onTap: () {
                        pickFile(extension: [
                          'jpg',
                          'jpeg',
                          'png',
                          'gif',
                          'bmp',
                        ]);
                      }),
                ],
              ),
              SizedBox(
                height: RecorderSize.x30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icons: Icons.headset,
                      color: Colors.orange,
                      text: 'Audio',
                      onTap: () {
                        pickFile(extension: [
                          'wav',
                          'aiff',
                          'alac',
                          'flac',
                          'mp3',
                          'aac',
                          'wma',
                          'ogg'
                        ]);
                      }),
                  SizedBox(
                    width: RecorderSize.x40,
                  ),
                  iconCreation(
                      icons: Icons.location_pin,
                      color: Colors.teal,
                      text: "Location",
                      onTap: () {}),
                  SizedBox(
                    width: RecorderSize.x40,
                  ),
                  iconCreation(
                      icons: Icons.person,
                      color: Colors.blue,
                      text: "Contact",
                      onTap: () async {
                        Contact? contact = await _contactPicker.selectContact();
                        setState(() {
                          _contacts = contact == null ? null : [contact];
                          message.text =
                              '${contact?.fullName ?? ''} (${contact?.phoneNumbers?.first ?? ''})';
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickFile({required List<String> extension}) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extension,
      );

      final filePath = result?.files.single.path;
      final fileExtension = filePath?.split('.').last.toLowerCase();

      print(
          'File>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. extension: $fileExtension');
      if (result != null) {
        if (result.files.single.path!.split('.').last.toLowerCase() == 'jpg' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'jpeg' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'png' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'gif' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'bmp') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraViewPage(
                  IconBackGroundColor: widget.recordIconBackGroundColor!,
                  path: result.files.single.path!,
                  onDataCameraReceived: widget.functionDataCameraReceived),
            ),
          );
        } else if (result.files.single.path!.split('.').last.toLowerCase() ==
                'mp4' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'avi' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'mov' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'vmv' ||
            result.files.single.path!.split('.').last.toLowerCase() == 'flv') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoViewPage(
                  IconBackGroundColor: widget.recordIconBackGroundColor!,
                  path: result.files.single.path!,
                  onDataVideoReceived: widget.functionDataCameraReceived),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileViewPage(
                IconBackGroundColor: widget.recordIconBackGroundColor!,
                path: result.files.single.path!,
                onDataFileReceived: widget.functionDataCameraReceived,
                audioExtensions: extension,
              ),
            ),
          );
        }
      } else {
        // User canceled the picker
      }
    } else {}
  }

  Widget iconCreation(
      {required IconData icons,
      required Color color,
      required String text,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: EmojiPicker(
          onEmojiSelected: (category, emoji) {
            show = false;
            setState(() {});
          },
          textEditingController: message,
          // scrollController: _scrollController,
          config: Config(
            height: RecorderSize.x250,
            checkPlatformCompatibility: true,
            emojiViewConfig: const EmojiViewConfig(
                // Issue: https://github.com/flutter/flutter/issues/28894
                emojiSizeMax: 28
                /* (foundation.defaultTargetPlatform ==
          TargetPlatform.iOS
          ? 1.2
          : 1.0),*/
                ),
            skinToneConfig: SkinToneConfig(
                indicatorColor: widget.recordIconBackGroundColor!),
            categoryViewConfig: CategoryViewConfig(
                iconColorSelected: widget.recordIconBackGroundColor!,
                indicatorColor: widget.recordIconBackGroundColor!),
            bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
            searchViewConfig: SearchViewConfig(
                backgroundColor: widget.recordIconBackGroundColor!),
          )),
    );
  }
}
