import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../uttils/appConstant.dart';
import 'followrequest_controller.dart';

class FollowRequestBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<FollowRequestController>(() => FollowRequestController(getStorage:  GetStorage(AppConstant.storageName)));
  }
}