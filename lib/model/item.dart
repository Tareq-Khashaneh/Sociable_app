
import 'package:task_1/model/Publisher.dart';
import 'package:task_1/model/interactions_count_types.dart';
import 'package:task_1/model/media.dart';

enum ModelType { profile , post }
class Item{
    final String? content;
    final int? interactionsCount;
    final InteractionsCountType? interactionsCountType;
    final int? commentsCount;
    final int? sharesCount;
    final int? tagsCount;
    final bool? sharingPost;
    final bool? hasMedia;
    final String? createdAt;
    late List<Media> mediasObj;
    List<dynamic>? medias;
    late List<String> tags;
    final Publisher? publisher;
  Item( {required this.content,  this.interactionsCount,  this.interactionsCountType,  this.commentsCount,  this.sharesCount,  this.tagsCount,  this.sharingPost,  this.hasMedia, this.publisher, this.createdAt, this.medias})
  {
    mediasObj = [];
    tags = [];
  }
  factory Item.fromJson (Map<String,dynamic> data)
  => Item(content: data['content'], interactionsCount: data['interactions_count'], interactionsCountType:  InteractionsCountType.fromJson(data['interactions_count_types']) , commentsCount: data['comments_count'], sharesCount: data['shares_count'], tagsCount: data['tags_count'], sharingPost: data['sharing_post'], hasMedia: data['has_media'],publisher: Publisher.fromJson(data['model']),createdAt: data['created_at'],medias: data['media']);
    Map<String,dynamic> toJson()
    => {
    "content": content, //required without media.
    for(int i =0 ; i< mediasObj.length ; i++)
    "media[$i]": mediasObj[i].toJson(), 
    "friends_ids": [] // The IDs of the profiles ,array, optinoal
};
}
// List<Item> items = [
//   Item(content: 'hi', interactionsCount: 12, interactionsCountType: InteractionsCountType(like: 12, love: 20, care: 15, haha: 55, wow: 0, sad: 0, angry: 1), commentsCount: 3, sharesCount: 10, tagsCount: 2, sharingPost: false, hasMedia: false, publisher: Publisher(name: 'test',medias: []), createdAt: '2023-07-31T06:51:22.000000Z', medias: []),
//   Item(content: 'hi2', interactionsCount: 23, interactionsCountType: InteractionsCountType(like: 222, love: 20, care: 15, haha: 55, wow: 0, sad: 0, angry: 1), commentsCount: 3, sharesCount: 10, tagsCount: 2, sharingPost: false, hasMedia: false, publisher: Publisher(name: 'test',medias: []), createdAt: '2023-07-31T06:51:22.000000Z', medias: []),
//   Item(content: 'hi3', interactionsCount: 12, interactionsCountType: InteractionsCountType(like: 0, love: 20, care: 15, haha: 55, wow: 0, sad: 0, angry: 1), commentsCount: 3, sharesCount: 10, tagsCount: 2, sharingPost: false, hasMedia: false, publisher: Publisher(name: 'test',medias: []), createdAt: '2023-07-31T06:51:22.000000Z', medias: []),
//   Item(content: 'hi4', interactionsCount: 12, interactionsCountType: InteractionsCountType(like: 12, love: 354, care: 15, haha: 55, wow: 0, sad: 0, angry: 1), commentsCount: 3, sharesCount: 10, tagsCount: 2, sharingPost: false, hasMedia: false, publisher: Publisher(name: 'test',medias: []), createdAt: '2023-07-31T06:51:22.000000Z', medias: []),
//   Item(content: 'hi5', interactionsCount: 12, interactionsCountType: InteractionsCountType(like: 12, love: 20, care: 15, haha: 55, wow: 222, sad: 0, angry: 1), commentsCount: 3, sharesCount: 10, tagsCount: 2, sharingPost: false, hasMedia: false, publisher: Publisher(name: 'test',medias: []), createdAt: '2023-07-31T06:51:22.000000Z', medias: []),
// ];