import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class MediaSquare extends StatelessWidget {
  const MediaSquare(
      {super.key, required this.file, required this.media, this.onDelete});
  final File file;
  final XFile media;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    late VideoPlayerController controller;
    File file = File(media.path);
    final mimeType = lookupMimeType(file.path);
    final mediaType = mimeType!.startsWith('image') ? 'Image' : 'Video';
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
                    )
                  : VideoPlayer(controller)),
        ),
        Positioned(
          right: -1,
          top: -9,
          child: IconButton(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text('Delete Image'),
                content: Text('Are you sure you want to delete this image?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog without deleting
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // cpc.mediasFiles.remove(media);
                      onDelete!();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Delete'),
                  ),
                ],
              ));
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
