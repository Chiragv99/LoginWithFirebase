import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/common/tabbar_controller.dart';
import 'package:loginwithfirebase/screens/home/home_screen.dart';
import 'package:loginwithfirebase/screens/myblog/myblog_screen.dart';
import 'package:loginwithfirebase/screens/profile/profile_screen.dart';
import 'package:loginwithfirebase/screens/setting/setting_screen.dart';
import '../screens/post/post_screen.dart';
import '../uttils/appConstant.dart';
import '../uttils/theme_color.dart';
import '../widget/fade_indexed_widget.dart';

class TabBarScreen extends GetView<TabBarController>{
  const TabBarScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.backgroundColor,
      child: SafeArea(
        top: false,bottom: false,
        maintainBottomViewPadding: true,
        child: Obx(() => Scaffold(
          backgroundColor: ThemeColor.backgroundColor,
          body: FadeIndexedStack(
            index: controller.selectedTabIndex.value,
            children:  [
              HomeScreen(),
              PostScreen(),
              ProfileScreen(),
              SettingScreen(),
            ],
          ),
          bottomNavigationBar: buildTabContainer(context),
        )),
      ),
    );
  }
  // TabBar Container
  Widget buildTabContainer(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: buildTabBar(context),
    );
  }

  // TabBar Widget
  Widget buildTabBar(BuildContext context){
    return TabBar(
        controller: controller.tabController,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom == 0.sp ? 10.sp : MediaQuery.of(context).padding.bottom + 10.sp, top: 10.sp, right: 10.sp, left: 10.sp),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50.sp),
            color: ThemeColor.primaryColor
        ),
        onTap: (value) {

        },
        tabs: [
          Tab(
            icon: controller.selectedTabIndex.value == 0 ? Image.asset("${AppConstant.assestPath}home_tab_icon.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}home_tab_icon.png", width: 24.sp, height: 24.sp),
          ),
          Tab(
            icon: controller.selectedTabIndex.value == 1 ? Image.asset("${AppConstant.assestPath}addpost.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}addpost.png", width: 24.sp, height: 24.sp),
          ),
          Tab(
            icon: controller.selectedTabIndex.value == 2 ? Image.asset("${AppConstant.assestPath}profile_tab_icon.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}profile_tab_icon.png", width: 24.sp, height: 24.sp),
          ),
          Tab(
            icon: controller.selectedTabIndex.value == 3 ? Image.asset("${AppConstant.assestPath}setting.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}setting.png", width: 24.sp, height: 24.sp),
          ),
        ]);
  }
}