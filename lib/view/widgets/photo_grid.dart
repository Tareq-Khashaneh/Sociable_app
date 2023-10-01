import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/model/media.dart';
import 'package:task_1/view/widgets/media_squre.dart';

class PhotoGrid extends StatefulWidget {
      final int maxImages;
      // final List<String> imageUrls;
      final List<Media> medias;
      final Function(int) onImageClicked;
      final Function onExpandClicked;

  PhotoGrid(
      {required this.medias,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      super.key});
      @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return Expanded(
      child: SizedBox(
        height: Get.size.height * 0.3,
        child: GridView(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          children: images,
        ),
      ),
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.medias.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      // String imageUrl = widget.medias[index];
      File file = widget.medias[index].mediaFile!;

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child:
            MediaSquare(file: file,isPost: true,),
            // Image.file(file,fit: BoxFit.cover,) ,
            // Image.network(
            //   imageUrl,
            //   fit: BoxFit.cover,
            // ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image.network(imageUrl, fit: BoxFit.cover),
                   MediaSquare(file: file,),
                  // Image.file(file,fit: BoxFit.cover,) ,
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child:
           MediaSquare(file: file,),
            // Image.file(file,fit: BoxFit.cover,) , 
          // Image.network(
          //   imageUrl,
          //   fit: BoxFit.cover,
          // ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}