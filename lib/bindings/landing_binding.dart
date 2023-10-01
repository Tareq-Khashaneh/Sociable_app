







import 'package:get/get.dart';
import 'package:task_1/controller/landong_controller.dart';
class LandingBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(LandingPageController());
  }


  

}