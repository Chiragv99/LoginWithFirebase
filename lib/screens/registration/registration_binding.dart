import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/registration/registration_controller.dart';

class RegistrationBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }

}