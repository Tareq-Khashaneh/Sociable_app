import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:task_1/controller/landong_controller.dart';
import 'package:task_1/shared/app_bar.dart';
import 'package:task_1/view/screens/create_post_screen.dart';
import 'package:task_1/view/screens/home._screen.dart';

class LandingScreen extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, lc) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: lc.changeTabIndex,
          currentIndex: lc.tabIndex.value,
          backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            buildBottomNavBarItem(Icons.home,"Home"),
            buildBottomNavBarItem(Icons.post_add_rounded,"Add Post"),
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController lc =
        Get.find();
    return SafeArea(
        child: Scaffold(
          
      bottomNavigationBar:
          buildBottomNavigationMenu(context, lc),
      body: Obx(() => LazyLoadIndexedStack(
            index: lc.tabIndex.value,
            children: [
              HomeScreen(),
              CreatePostScreen()
             
            ],
          )),
    ));
  }
  
  buildBottomNavBarItem(IconData icon , String label)
  
    => BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    icon,
                    size: 20.0,
                  ),
                ),
                label: label,
                // backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              );
  
}