import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:task_1/shared/dialogue.dart';
import 'package:video_player/video_player.dart';

class MediaSquare extends StatelessWidget {
  const MediaSquare(
      {super.key, required this.file, this.isPost = false, this.onDelete});
  final File file;
  final Function? onDelete;
  // ignore: prefer_typing_uninitialized_variables
  final isPost;
  @override
  Widget build(BuildContext context) {
    late VideoPlayerController controller;
    final mimeType = lookupMimeType(file.path);
    final mediaType = mimeType != null
        ? mimeType.startsWith('image')
            ? 'Image'
            : 'Video'
        : 'Image';
    if (mediaType == 'Video') {
      controller = VideoPlayerController.file(file)..initialize();
    }
    return  Stack(
      children: [
        mediaType == "Image"
            ? Container(
                decoration: BoxDecoration
                (borderRadius: BorderRadius.circular(5),
                  color: Colors.black87,
                  image: DecorationImage(
                      image: Image.file(
                        file,
                        // fit: BoxFit.cover,
                      ).image,
                      fit: BoxFit.cover),
                ))
            : ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: VideoPlayer(controller)),
       if(!isPost)
          Positioned(
            right: -1,
            top: -9,
            child: IconButton(
              onPressed: () {
               buildDialogue(onDelete!);
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
                size: 18,
              ),
            ),
          ),
      ],
    );
  
  }
}
