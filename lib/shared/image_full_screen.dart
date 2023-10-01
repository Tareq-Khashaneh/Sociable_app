
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_layout/multi_image_layout.dart';

class ImageFullScreen extends StatelessWidget {
  final File file;

  ImageFullScreen({required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: PhotoView(
            imageProvider: FileImage(file),
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}