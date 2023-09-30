import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/constants/routes.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key, });
  
  final List<String> routes = [
    ScreenRoutes.homeRoute,
    ScreenRoutes.createPostRoute
  ]; final RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return 
    Obx(() =>   BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
          Get.offNamed(routes.elementAt(selectedIndex.value));
        
        },
        items: items)
 );
   }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
    const BottomNavigationBarItem(
        label: "Add Post", icon: Icon(Icons.post_add)),
  ];
}
