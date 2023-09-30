import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/constants/routes.dart';
import 'package:task_1/core/functions.dart';

Widget _buildMenuItem(
    BuildContext context, Widget title, String routeName, String currentRoute,IconData icon) {  final isSelected = routeName == currentRoute;

  return ListTile(
    title: title,
    leading: Icon(icon),
    selected: isSelected,
    onTap: () {
      if (isSelected) {
        Get.back();
      } else {
        Get.toNamed(routeName);
      }
    },
  );
}

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    width: Get.size.width * 0.74,
    child: ListView(
      children: <Widget>[
       DrawerHeader(
            child: SizedBox(),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage("assets/images/post.jpg"),
                     fit: BoxFit.cover)
              ),
            ),
        _buildMenuItem(
          context,
          const Text('Home'),
          ScreenRoutes.homeRoute,
          currentRoute,
          Icons.home
        ),
        _buildMenuItem(
          context,
          const Text('add post'),
          ScreenRoutes.createPostRoute,
          currentRoute,
          Icons.post_add
        ),
       
      ],
    ),
  );
}
