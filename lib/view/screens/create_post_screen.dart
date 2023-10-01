import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:task_1/constants/routes.dart';
import 'package:task_1/controller/create_post_controller.dart';
import 'package:task_1/controller/landong_controller.dart';
import 'package:task_1/core/functions.dart';
import 'package:task_1/model/media.dart';
import 'package:task_1/shared/app_bar.dart';
import 'package:task_1/shared/loading_indicator.dart';
import 'package:task_1/view/widgets/media_squre.dart';
import 'package:video_player/video_player.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final CreatePostController cpc = Get.find();
  final LandingPageController lc = Get.find();
  final double height = 10;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
            appBar: BaseAppBar(
          title: Text('Create Post'),
          appBar: AppBar(),
          widgets: []),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSize(height),
                    Stack(
                      children: [
                        TextFormField(
                          controller: cpc.contentc,
                          maxLines: 8,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16.0,
                            ),
                            label: Text("Content"),
                            hintText: 'What\'s on your mind?',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        // bottomRight: Radius.circular(10)
                                        ),
                                    color: Colors.redAccent),
                                child: IconButton(
                                    onPressed: cpc.pickMediasCamera,
                                    icon: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                              ),
                                    Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(10)),
                                    color: Colors.blue),
                                child: IconButton(
                                    onPressed: cpc.pickMedias,
                                    icon: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                              ),
                      
                            ],
                          ),
                        )
                      ],
                    ),
                    addVerticalSize(height),
                    Text("Media"),
                    addVerticalSize(12),
                    Expanded(
                        child: Obx(() => cpc.isLoading
                                ? const Center(
                                    child: LoadingIndicator(),
                                  )
                                : buildGridView()
                             )),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async {
            final isCreated = await cpc.createPost();
            
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            if(isCreated)
            {
              lc.changeTabIndex(0);
            }
          },
          child: const Center(
            child: Icon(
              Icons.post_add_outlined,
              size: 33,
            ),
          ),
        ),
        //  bottomNavigationBar: 
            
        //     BottomNavBar()
         
      ),
    );
  }

  Widget buildGridView() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: GridView.count(crossAxisCount: 3, children: [
            ...cpc.mediasFiles.map((media) {
              File file = File(media.path);
              return MediaSquare(
                file: file,
                onDelete: () => cpc.mediasFiles.remove(media),
              );
            })
          ]),
        ));
  }
}
