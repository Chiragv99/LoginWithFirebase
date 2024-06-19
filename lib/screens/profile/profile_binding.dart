import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/screens/profile/profile_controller.dart';

import '../../uttils/appConstant.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(getStorage: GetStorage(AppConstant.storageName)));
  }
}