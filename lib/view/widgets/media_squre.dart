import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:task_1/shared/dialogue.dart';
import 'package:video_player/video_player.dart';

class MediaSquare extends StatelessWidget {
  const MediaSquare(
      {super.key,
      required this.file,
      this.isPost = false,
      this.onDelete});
  final File file;
  final VoidCallback? onDelete;
  final isPost;
  @override
  Widget build(BuildContext context) {
    late VideoPlayerController controller;
    final mimeType = lookupMimeType(file.path);
    final mediaType = mimeType != null ? mimeType.startsWith('image') ? 'Image' : 'Video' : 'Image';
    if (mediaType == 'Video') {
      controller = VideoPlayerController.file(file)..initialize();
    }
    return Stack(
      children: [
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: mediaType == "Image"
                  ? Image.file(
                      file,
                      fit: BoxFit.cover,
                    )
                  : VideoPlayer(controller)),
        ),
        if (isPost)
          Positioned(
            right: -1,
            top: -9,
            child: IconButton(
              onPressed: () {
                buildDialogue(() => onDelete!());
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
