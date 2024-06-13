import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TabBarController extends GetxController  with GetSingleTickerProviderStateMixin{

  // For Store Data
  GetStorage getStorage;

  TabBarController({required this.getStorage});

  late TabController tabController;
  RxInt selectedTabIndex = RxInt(0);

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