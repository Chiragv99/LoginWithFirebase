
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:loginwithfirebase/screens/test/test_controller.dart';

class TestBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<TestController>(() => TestController());
  }
}