


import 'package:get/get.dart';
import 'package:task_1/controller/home_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }


  

}