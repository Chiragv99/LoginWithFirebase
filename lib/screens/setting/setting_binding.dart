import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/setting/setting_controller.dart';

class SettingBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }

}