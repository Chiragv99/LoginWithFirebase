import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/setProfileData.dart';

class TabBarController extends GetxController  with GetSingleTickerProviderStateMixin{

  // For Store Data
  GetStorage getStorage;

  TabBarController({required this.getStorage});

  late TabController tabController;
  RxInt selectedTabIndex = RxInt(0);

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
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}