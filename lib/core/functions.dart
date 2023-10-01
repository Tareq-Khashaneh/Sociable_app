


import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addVerticalSize(double height) => SizedBox(height: height,);
Widget addHorizantolSize(double width) => SizedBox(width: width,);
SnackbarController showMessage(String title , String message) {
 return Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    borderRadius: 10.0,
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    duration: Duration(seconds: 3),
    dismissDirection: DismissDirection.down,
    isDismissible: true,
   
    forwardAnimationCurve: Curves.easeOut,
    reverseAnimationCurve: Curves.easeIn,
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 14.0,
      ),
    ),
   
    icon: Icon(
      Icons.info,
      color: Colors.white,
    ),
    shouldIconPulse: true,
    leftBarIndicatorColor: Colors.white,
  );
}
String formatDuration(String dateCreatePost) {
  
  DateTime postCreationDate = DateTime.parse(dateCreatePost);
  DateTime currentDate = DateTime.now();

  Duration duration = currentDate.difference(postCreationDate);


   if (duration.inDays > 365) {
    int years = (duration.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (duration.inDays >= 30) {
    int months = (duration.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (duration.inDays >= 1) {
    return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
  } else if (duration.inHours >= 1) {
    return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (duration.inMinutes >= 1) {
    return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }


}  
