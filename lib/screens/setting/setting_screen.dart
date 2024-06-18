import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loginwithfirebase/screens/setting/setting_controller.dart';
import 'package:loginwithfirebase/uttils/theme_color.dart';
import 'package:loginwithfirebase/uttils/uttils.dart';
import 'package:loginwithfirebase/widget/common_widget.dart';

import '../../uttils/appConstant.dart';

class SettingScreen extends GetView<SettingController>{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ThemeColor.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                labelTextRegular("Setting", 16, Colors.black),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Container(
              decoration: settingDecoration(),
              child: buildSettingListView(controller),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildSettingListView(SettingController controller){
  return Obx (() =>  ListView.separated(
    separatorBuilder: (context,index) => Divider(
      thickness: 1,
      color:  ThemeColor.lightTextColor.withOpacity(.2),
    ),
    itemCount:  controller.listSettingData.length,
    shrinkWrap: true,
    primary: false,
    itemBuilder: (context,index){
      return GestureDetector(
        onTap: (){},
        child: buildSettingItem(index,context,controller),
      );
    },
  ));
}
// Box Decoration for Setting
BoxDecoration settingDecoration(){
  return  BoxDecoration(
    border:
    Border.all(color: ThemeColor.disableColor, width: 0.1),
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: Colors.white,
        blurRadius: 3.0,
        offset: Offset(0.0, 3.0),
      ),
    ],
  );
}

Widget buildSettingItem(int index, BuildContext context, SettingController controller){
  return InkWell(
    splashColor: ThemeColor.disableColor,
    onTap: () {

    },
    child: Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(0.0),
      child: SizedBox(
        width: Get.width,
        child: Row(
          children: [
            Image(image: AssetImage(AppConstant.assestPathIcon +
                controller.listSettingData[index].icons)),
            SizedBox(
              width: 5.sp,
            ),
            Expanded(child:
            labelTextLight(controller.listSettingData[index].titles, 10, ThemeColor.darkTextColor),),
            controller.listSettingData[index].languageData != null ? labelTextBold(controller.listSettingData[index].languageData, 14, ThemeColor.lightTextColor) :
            0.wSpace,
          ],
        ),
      ),
    ),
  );
}

