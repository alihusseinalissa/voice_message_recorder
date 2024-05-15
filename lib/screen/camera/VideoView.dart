import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_message_recorder/mySize.dart';

class VideoViewPage extends StatefulWidget {
  final Function(String) onDataVideoReceived;
  final Color IconBackGroundColor;
  const VideoViewPage(
      {Key? key,
      required this.path,
      required this.IconBackGroundColor,
      required this.onDataVideoReceived})
      : super(key: key);
  final String path;

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(
                Icons.crop_rotate,
                size: MM.x27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.title,
                size: MM.x27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.edit,
                size: MM.x27,
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.symmetric(vertical: MM.x5, horizontal: MM.x8),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MM.x17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Caption....",
                      prefixIcon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: MM.x27,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MM.x17,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          widget.onDataVideoReceived(widget.path);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          radius: MM.x27,
                          backgroundColor: widget.IconBackGroundColor,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: MM.x27,
                          ),
                        ),
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: MM.x33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: MM.x50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
