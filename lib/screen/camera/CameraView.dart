import 'dart:io';

import 'package:flutter/material.dart';

import '../../recorderSize.dart';

class CameraViewPage extends StatelessWidget {
  final Function(String) onDataCameraReceived;
  final Color IconBackGroundColor;
  const CameraViewPage(
      {super.key,
      required this.path,
      required this.IconBackGroundColor,
      required this.onDataCameraReceived});
  final String path;

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
                size: RecorderSize.x27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.emoji_emotions_outlined,
                size: RecorderSize.x27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.title,
                size: RecorderSize.x27,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.edit,
                size: RecorderSize.x27,
              ),
              onPressed: () {}),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    vertical: RecorderSize.x5, horizontal: RecorderSize.x8),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: RecorderSize.x17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Caption....",
                      prefixIcon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: RecorderSize.x27,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: RecorderSize.x17,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          onDataCameraReceived(path);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          radius: RecorderSize.x27,
                          backgroundColor: IconBackGroundColor,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: RecorderSize.x27,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
