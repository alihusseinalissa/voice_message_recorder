import 'package:flutter/material.dart';
import 'package:voice_message_recorder/mySize.dart';

import 'audio/player.dart';

class FileViewPage extends StatefulWidget {
  final Function(String) onDataFileReceived;
  final List<String> audioExtensions;
  final Color IconBackGroundColor;
  FileViewPage(
      {Key? key,
      required this.path,
      required this.IconBackGroundColor,
      required this.onDataFileReceived,
      required this.audioExtensions})
      : super(key: key);
  final String path;

  @override
  State<FileViewPage> createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  String extension = '';
  @override
  void initState() {
    super.initState();
    extension = widget.path.split('.').last.toLowerCase();
    print(
        "-------------------------->>>>  $extension                ${widget.path}");
  }

  Icon getFileIcon({required double size}) {
    switch (extension) {
      case 'mp4':
      case 'avi':
      case 'mov':
        return Icon(
          size: size,
          Icons.videocam,
          color: Colors.grey,
        );
      case 'mp3':
      case 'wav':
        return Icon(
          size: size,
          Icons.audiotrack,
          color: Colors.grey,
        );
      case 'doc':
      case 'docx':
        return Icon(
          size: size,
          Icons.description,
          color: Colors.grey,
        );
      case 'pdf':
        return Icon(
          size: size,
          Icons.picture_as_pdf,
          color: Colors.grey,
        );
      case 'zip':
        return Icon(
          size: size,
          Icons.archive,
          color: Colors.grey,
        );
      case 'apk':
        return Icon(
          size: size,
          Icons.android,
          color: Colors.grey,
        );
      default:
        return Icon(
          size: size,
          Icons.insert_drive_file,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: widget.IconBackGroundColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MM.x50,
            ),
            Container(
              height: MM.x200,
              child: widget.audioExtensions.contains(extension)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getFileIcon(size: MM.x100),
                        Text(
                          widget.path.split('/').last,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  : MyHomePage(
                      path: widget.path,
                      IconBackGroundColor: widget.IconBackGroundColor,
                    ),
            ),
            Container(
              color: Colors.black38,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: MM.x5, horizontal: MM.x8),
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
                        widget.onDataFileReceived(widget.path);
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
          ],
        ),
      ),
    );
  }
}
