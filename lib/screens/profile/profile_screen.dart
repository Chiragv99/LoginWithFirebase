import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/profile/profile_controller.dart';
import 'package:loginwithfirebase/uttils/theme_color.dart';

class ProfileScreen extends  GetView<ProfileController>{
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
        child: Scaffold(
          backgroundColor: ThemeColor.backgroundColor,
          body: SafeArea(
              child: Column(
                children: [
                  Obx (() => buildCardDetail())
                ],
              )),
        ),
      ),
    );
  }
}

Widget buildCardDetail(){
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(
        left:  30.sp,
        right: 30.sp
      ),
      child:  Column(
        children: [
          30.horizontalSpace,
          Center(
            child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColor.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(90.r))
              ),
              child: SizedBox(
              ),
            ),
          )
        ],
      ),
    ),
  );
}