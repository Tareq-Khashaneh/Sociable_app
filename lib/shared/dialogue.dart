import 'package:flutter/material.dart';
import 'package:get/get.dart';

buildDialogue(Function onDelete) {
 
  Get.dialog(AlertDialog(
    title: Text('Delete Image'),
    content: Text('Are you sure you want to delete this image?'),
    actions: [
      TextButton(
        onPressed: () {
          Get.back(); // Close the dialog without deleting
        },
        child: Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
    
          
           onDelete();
    
          Get.back();
          
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text('Delete'),
      ),
    ],
  ));
}
