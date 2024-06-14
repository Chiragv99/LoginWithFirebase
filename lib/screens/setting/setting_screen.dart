
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loginwithfirebase/screens/setting/setting_controller.dart';

import '../../uttils/appConstant.dart';
import '../../uttils/theme_color.dart';
import '../../widget/common_widget.dart';

class SettingScreen extends GetView<SettingController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
      Container(
        decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
        color: Colors.grey.shade300,
        child:  Scaffold(
           backgroundColor: ThemeColor.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                Get.back();
              },
              child:Image.asset('${AppConstant.assestPathIcon}icon_back.png') ,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                labelTextRegular("profile_title".tr, 16, ThemeColor.darkTextColor)
              ],
            ),
          ),
          body: SafeArea(child: Column(
            children: [
              Obx(() => buildCardDetail())
            ],
          )),
        )
      )),
    );
  }

}

Widget buildCarDetail(){
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(
        left: 30.sp,
        right: 30.sp
      ),
      child: Column(

        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColor.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(90.r))
              ),
              child: SizedBox(
                child: crea,
              ),
            ),
          )
        ],
      ),
    ),
  );
}