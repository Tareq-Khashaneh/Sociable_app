import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({ super.key,required this.title,required this.appBar,required this.widgets});

  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
      
      actions: widgets,
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
