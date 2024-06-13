import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/screens/login/login_controller.dart';

import '../../uttils/appConstant.dart';


class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(getStorage:  GetStorage(AppConstant.storageName)));
  }
}