import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/screens/myblog/myblog_controller.dart';
import '../../uttils/appConstant.dart';

class MyblogBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MyBlogController>(() => MyBlogController(getStorage:  GetStorage(AppConstant.storageName)));
  }
}