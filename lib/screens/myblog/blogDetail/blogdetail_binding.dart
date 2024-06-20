import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../uttils/appConstant.dart';
import 'blogdetail_controller.dart';

class BlogDetailBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BlogDetailController>(() => BlogDetailController(getStorage:  GetStorage(AppConstant.storageName)));
  }
}