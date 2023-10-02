import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_layout/gallery_photo_view_wrapper.dart';
import 'package:multi_image_layout/image_model.dart';
import 'package:task_1/core/functions.dart';
import 'package:task_1/model/item.dart';
import 'package:task_1/model/media.dart';
import 'package:task_1/shared/image_full_screen.dart';
import 'package:task_1/shared/video_full_screen.dart';
import 'package:task_1/view/widgets/click_button.dart';
import 'package:multi_image_layout/multi_image_viewer.dart';
import 'package:task_1/shared/media_squre.dart';
import 'package:task_1/view/widgets/photo_grid.dart';

class PostCard extends StatelessWidget {
  PostCard({super.key, required this.item});
  final double height = 10;
  final double width = 1.5;
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(8),  
      // alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: item.publisher!.imgProfile != null
                    ? Image.network('${item.publisher!.imgProfile}').image
                    : Image.asset('assets/images/profile.png').image,
              ),
              addHorizantolSize(7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item.publisher!.name.toString()),
                  Text(formatDuration(item.createdAt!))
                ],
              )
            ],
          ),
          addVerticalSize(height),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
            child: item.content != null
                ? Row(
                  children: [
                    Flexible(
                      child: Text(
                        
                          item.content!,
                        ),
                    ),
                  ],
                )
                : SizedBox(),
          ),
          // addVerticalSize(height),
          if (item.mediasObj.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: PhotoGrid(
                medias: item.mediasObj,
                onImageClicked: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            item.mediasObj[index].mediaType == MediaType.image
                                ? ImageFullScreen(
                                    file: item.mediasObj[index].mediaFile!)
                                : VideoFullScreen(
                                    video: item.mediasObj[index].mediaFile!)),
                  );
                },
                onExpandClicked: () => print('Expand Image was clicked'),
                maxImages: 4,
              ),

              
            ),
          // Image.network(item.mediasObj[0].srcUrl),
          // if (item.interactionsCount != 0)
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildReactions(),
              ),
              Row(
                children: [
                  addHorizantolSize(width),
                  Text(item.interactionsCount.toString()),
                ],
              )
            ],
          ),

          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClickButton(
                icon: Icons.thumb_up_off_alt_rounded,
                text: 'Like',
                count: item.interactionsCount!,
              ),
              ClickButton(
                icon: Icons.comment_rounded,
                text: 'Comment',
                count: item.commentsCount!,
              ),
              ClickButton(
                icon: Icons.share,
                text: 'Share',
                count: item.sharesCount!,
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildReactions() {
    List<Widget> icons = [];
    Map<String, int> reactions = item.interactionsCountType!.toJSon();
    List<MapEntry<String, int>> entries = reactions.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    List<MapEntry<String, int>> largestThree = entries.take(3).toList();

    for (MapEntry me in largestThree) {
      buildListReactions(me.key, icons);
    }
    return icons;
  }

  buildListReactions(String key, List<Widget> icons) {
    double size = 15;
    switch (key) {
      case 'haha':
        icons.add(
          Icon(
            Icons.sentiment_satisfied_alt_rounded,
            color: Colors.purple,
            size: size,
          ),
        );
      case 'like':
        icons.add(Icon(
          Icons.thumb_up_off_alt_rounded,
          color: Colors.blue,
          size: size,
        ));
        break;
      case 'love':
        icons.add(Icon(
          Icons.favorite, size: size, // Adjust the size as needed
          color: Colors.red,
        ));
        break;
      case 'wow':
        icons.add(Icon(
          Icons.sentiment_neutral_rounded,
          color: Colors.yellow,
          size: size,
        ));
        break;
      case 'sad':
        icons.add(Icon(
          Icons.sentiment_dissatisfied_rounded,
          color: Colors.blueGrey,
          size: size,
        ));
        break;
      case 'care':
        icons.add(
          Icon(
            Icons.stars_rounded,
            color: Colors.green,
            size: size,
          ),
        );
        break;
      case 'angry':
        icons.add(Icon(
          Icons.thumb_down_alt_rounded,
          color: Colors.grey,
          size: size,
        ));
        break;
    }
  }


}
