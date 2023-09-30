





import 'package:get/get.dart';
import 'package:task_1/controller/create_post_controller.dart';
class CreatePostBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(CreatePostController());
  }


  

}