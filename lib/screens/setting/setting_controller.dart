import 'package:get/get.dart';
import 'package:loginwithfirebase/models/setProfileData.dart';

class SettingController extends GetxController{

  RxBool isLoading = RxBool(false);

  RxList<SetProfileData> listSettingData = RxList([
    SetProfileData("icon_privacy.png", "privacy".tr,  null),
    SetProfileData("icon_help.png", "help".tr,  null),
    SetProfileData("lock.png", "changePassword".tr, ""),
    SetProfileData("translation.png", "language".tr, ""),
    SetProfileData("icon_logout.png", "log_out".tr, null)
  ]);

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
  }
}