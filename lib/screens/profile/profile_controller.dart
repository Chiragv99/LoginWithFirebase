import 'package:get/get.dart';

class ProfileController extends GetxController{

  // For Show Loading
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
  }
}