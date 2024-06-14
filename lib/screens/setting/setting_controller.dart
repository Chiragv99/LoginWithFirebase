import 'package:get/get.dart';

class SettingController extends GetxController{

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
  }
}