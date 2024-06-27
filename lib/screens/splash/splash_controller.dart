import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_routes.dart';
import '../../uttils/appConstant.dart';
import '../../uttils/preferenceUtils.dart';

class SplashController extends GetxController {

  // For Store Data
  GetStorage getStorage;

  SplashController({required this.getStorage});

  var keepMeLogin = false;
  @override
  void onInit() async{
    super.onInit();

    // Initialize PreferenceUtils instance.
    await PreferenceUtils.init();

    Future.delayed(const Duration(seconds: 4), () {
      keepMeLogin = PreferenceUtils.getBool(AppConstant.keepMeLogin,false)!;
      if(!keepMeLogin){
        Get.offAndToNamed(Routes.loginScreen);
      }
      else{
        redirectToIntroScreen();
      }
    });
  }

  redirectToIntroScreen() {
    Get.offAndToNamed(Routes.tabBarScreen);
  }
}
