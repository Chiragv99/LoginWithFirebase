import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/common/tabbar_controller.dart';
import 'package:loginwithfirebase/screens/home/home_controller.dart';
import 'package:loginwithfirebase/screens/myblog/myblog_controller.dart';
import 'package:loginwithfirebase/screens/post/post_controller.dart';
import 'package:loginwithfirebase/screens/setting/setting_controller.dart';

import '../uttils/appConstant.dart';

class TabBarBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<TabBarController>(() => TabBarController(getStorage: GetStorage(AppConstant.storageName)));
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => MyBlogController(getStorage: GetStorage(AppConstant.storageName)));
  }
}