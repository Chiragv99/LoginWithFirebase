import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/models/setProfileData.dart';

import '../../routes/app_routes.dart';
import '../../uttils/appConstant.dart';


class SettingController extends GetxController{



  // For Store Data
  GetStorage getStorage;

  SettingController({required this.getStorage});

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

  void showLogoutAlertDiloaug(BuildContext context){
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        getStorage.remove(AppConstant.keepMeLogin);
        Get.offAllNamed(Routes.loginScreen);
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r))
      ),
      content: const Text("Are You Sure want to Logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

