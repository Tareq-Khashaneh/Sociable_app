
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_1/model/item.dart';
import 'package:dio/dio.dart' as dio;
import 'package:task_1/services/api.dart';
import 'package:path/path.dart';
import '../model/media.dart';

class HomeController extends GetxController {
  void _firstLoad() async {
    isFirstLoadingRunning = true;
    try {
      fetchItems();
       isFirstLoadingRunning = false;
    } catch (e) {
      print(e.toString());
    }
  }

  void _loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadingRunning == false &&
        isLoadMoreRunning == false) {
      isLoadMoreRunning = true;
      page += 1;

      try {
        final dio.Response response =
            await dio.Dio().get("${Api.apiUrl}/all", queryParameters: {
          'page': page,
          'limit': limit,
        });
        final List<dynamic> fetchPosts = response.data['data']['items'];
        if (response.statusCode == 200 && fetchPosts.isNotEmpty) {
          List<dynamic> itemsJson = response.data['data']['items'];
          List<Item> temp = [];
          for (var i in itemsJson) {
            List<Media> publisherMedias = [];
            List<Media> postMedias = [];
            Item item = Item.fromJson(i);
            if (item.publisher!.medias.isNotEmpty) {
              for (var m in item.publisher!.medias) {
                publisherMedias.add(Media.fromJson(m)..setType());
              }
              item.publisher!.mediasObj = publisherMedias;
              for (Media m in publisherMedias) {
                if (m.collectionName == 'profile') {
                  item.publisher!.imgProfile = m.srcUrl;
                  break;
                }
              }
            }
            if (item.medias!.isNotEmpty) {
              for (var m in item.medias!) {
                postMedias.add(Media.fromJson(m)..setType());
              }
              item.mediasObj = postMedias;
            }
            temp.add(item);
          }
          items.addAll(temp);
          print("here");
        } else {
          hasNextPage = false;
        }
      } catch (e) {}

      isLoadMoreRunning = false;
    }
    
      isLoadMoreRunning = false;
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  void onInit() {
    // fetchItems();

    
      isLoadMoreRunning = false;
    selectedIndex = 0.obs;
    // _firstLoad();
   fetchItems();
    sc = ScrollController()
      ..addListener(() {
        if (sc.position.maxScrollExtent == sc.offset) {
          // _loadMore();
          print("isLo $isLoadMoreRunning");
          isLoadMoreRunning = true;
           fetchItems();
        }
      });
    super.onInit();
  }

  void fetchItems() async {
     Directory directory = await getApplicationDocumentsDirectory();
           
    dio.Dio dioo = dio.Dio();
    try {
      dio.Response response = await dioo.get("${Api.apiUrl}/all",
          options: dio.Options(
          headers: Api.headers),
          queryParameters: {
            'limit': limit,
            'page': page,
          });
           page += 1;

      if (response.statusCode == 200 &&
          response.data['message'] == "Here are all posts!") {
        List<dynamic> itemsJson = response.data['data']['items'];
        // print("ItemsJson $itemsJson");
        if(itemsJson.length < limit )
        {
          isLoadMoreRunning = false;
        }
        List<Item> temp = [];
        for (var i in itemsJson) {
          List<Media> publisherMedias = [];
          List<Media> postMedias = [];
          Item item = Item.fromJson(i);
          if (item.publisher!.medias.isNotEmpty) {
            for (var m in item.publisher!.medias) {
              publisherMedias.add(Media.fromJson(m)..setType());
            }
            item.publisher!.mediasObj = publisherMedias;
            for (Media m in publisherMedias) {
              if (m.collectionName == 'profile') {
                item.publisher!.imgProfile = m.srcUrl;
                break;
              }
            }
          }
          if (item.medias!.isNotEmpty) {
            for (var m in item.medias!) {
            final Reference refStorage = FirebaseStorage.instance.refFromURL(m['src_url']);

            print("name ${refStorage.name}");
            final path = "${directory.path}/${refStorage.name}";
            File file = File(path);
             await refStorage.writeToFile(file);
              postMedias.add(Media.fromJson(m)..setType()..mediaFile = file);
            }
            item.mediasObj = postMedias;
          }
          temp.add(item);
        }
        items.addAll(temp);

      }
      
    } on dio.DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  final int limit = 12;
  late int page = 1;
  late RxBool _hasNextPage = true.obs;
  late RxBool _isLoadMoreRunning ;
  late RxBool _isFirstLoadingRunning = false.obs;
  late ScrollController sc;
  late bool isLoading;
  final RxList<Item> _items = RxList([]);
  late RxInt selectedIndex;
  List<Item> get items => _items;
  bool get isLoadMoreRunning => _isLoadMoreRunning.value;
  bool get hasNextPage => _hasNextPage.value;
  bool get isFirstLoadingRunning => _isFirstLoadingRunning.value;
  set isLoadMoreRunning(bool isLoadMoreRunning) =>
      _isLoadMoreRunning = isLoadMoreRunning.obs;
  set hasNextPage(bool hasNextPage) => _hasNextPage = hasNextPage.obs;
  set isFirstLoadingRunning(bool isFirstLoadingRunning) =>
      _isFirstLoadingRunning = isFirstLoadingRunning.obs;
  set items(List<Item> items) => _items.value = items;
}
