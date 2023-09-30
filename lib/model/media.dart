
import 'dart:io';

import 'package:video_player/video_player.dart';

enum MediaType {image, video}
enum MimeType {gif,jpeg,png,mp4 }

class Media{

  final String? srcUrl;
  final String? srcThum;
  final String? srcIcon;
  final String? fullPath;
  final String? collectionName;
  final String? mediaTypeString;
  final String? mimeTypeString;
  final int? width;
  final int? height;
  final int? size;
  File? mediaFile;
  MimeType? mimeType;
  MediaType? mediaType;
  VideoPlayerController? controller;
  Media(  { this.srcUrl,  this.collectionName ,  this.mimeTypeString, this.mediaTypeString ,  this.srcThum, this.srcIcon, this.fullPath ,  this.width, this.height,  this.size})
;
  factory Media.fromJson(Map<String,dynamic> data)
  => Media(srcUrl: data['src_url'], collectionName: data['collection_name'], mediaTypeString: data['media_type'], mimeTypeString: data['mime_type'],srcThum: data['src_thum'],srcIcon: data['src_icon'],fullPath: data['full_path'],width: data['width'],height: data['height'],size: data['size']);
  Map<String,dynamic> toJson()
  =>{
    "src_url": srcUrl, //required
            "src_thum": srcThum, //optional
            "src_icon": srcIcon, //optional
            "media_type": mediaTypeString, //required 
            "mime_type": mimeTypeString, //required
            "fullPath": fullPath, //required ex:posts/media-3702f
            "width": width , //integer, required when media_type is Video
            "height":height , //integer, required when media_type is Video
            "size": size
  };
  void setType(){
    switch(mediaTypeString)
    {
      case 'Image':
      mediaType = MediaType.image;
      break;
      case 'Video':
      mediaType = MediaType.video;
      break;
    }
    switch(mimeTypeString)
    {
      case 'gif':
      mimeType = MimeType.gif;
      break;
      case 'jpeg' || 'image/jpeg':
      mimeType = MimeType.jpeg;
      break;
      case 'mp4':
      mimeType = MimeType.mp4;
      break;
    }
  }
}