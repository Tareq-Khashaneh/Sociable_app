import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/model/media.dart';
import 'package:task_1/shared/media_squre.dart';

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
  late  double height;
  late  double width;
  @override
  void initState() {
    height = Get.size.height;
    width = Get.size.width;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    int numImages = widget.medias.length;
    if(numImages == 1 || numImages == 2)
    {
       height = height * 0.85;
    }else if(numImages == 3 || numImages == 4)
    {
      height = 215;
    }
    return SizedBox(
      // height:  height ,
      // width:numImages == 1 ?  width  : width,
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: numImages == 1 ?  400 : 200,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 16/9
        ),
        children: images,
      ),
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.medias.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      // String imageUrl = widget.medias[index];
      File? file = widget.medias[index].mediaFile;

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return   file !=null ?  GestureDetector(
            child:
         MediaSquare(file: file,isPost: true,),
            
            
            onTap: () => widget.onImageClicked(index),
          ) : SizedBox();
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return file !=null ? GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image.network(imageUrl, fit: BoxFit.cover),
                   
           MediaSquare(file: file,isPost: true),
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
          ):SizedBox();
        }
      } else {
        return file !=null ? GestureDetector(
          child:
          // SizedBox(),
          
           MediaSquare(file: file,isPost: true),
       
          onTap: () => widget.onImageClicked(index),
        ):SizedBox();
      }
    });
  }
  
}