


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/core/functions.dart';

class ClickButton extends StatelessWidget {
  ClickButton({super.key, required this.icon, required this.text, required this.count});
  final IconData icon;
  final String text;
   final int count;
  late RxInt counter = count.obs;
  late bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: InkWell(
        onTap: (){
         !isClicked ? counter++ : counter--;
         isClicked = !isClicked;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          // alignment: Alignment.center,
          margin: EdgeInsets.only(left: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Icon(icon,color: Colors.blue,size: 20,)),
             
              Expanded(
                child: 
                Obx(() =>  Text("$counter",
                 style: TextStyle(fontSize: 14),
                ))
               )
            ],
          ),
        ),
      ),
    );
    
    }
}