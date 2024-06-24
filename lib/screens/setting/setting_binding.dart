import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/screens/setting/setting_controller.dart';

import '../../uttils/appConstant.dart';

class SettingBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController(getStorage: GetStorage(AppConstant.storageName)));
  }

}