import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/post/post_controller.dart';

class PostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
  }

}