import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/profile/profile_controller.dart';
import 'package:loginwithfirebase/uttils/theme_color.dart';

import '../../routes/app_routes.dart';
import '../../uttils/appConstant.dart';
import '../../uttils/uttils.dart';
import '../../widget/common_widget.dart';
import '../../widget/round_button.dart';

class ProfileScreen extends  GetView<ProfileController>{
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Container(
        decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
        child: Scaffold(
          backgroundColor: ThemeColor.backgroundColor,
          appBar: topHeaderWithBackIcon("profile_title".tr),
          body: SafeArea(
              child: Column(
                children: [buildCarDetail(controller,context)],
              )),
        ),
    );
  }
}

Widget buildCarDetail(ProfileController controller, BuildContext context) {
  return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.sp,
          right: 30.sp,
        ),
        child: Column(children: [
          30.hSpace,
          GestureDetector(
            onTap: (){
              print("Profile"+ "Click");
              showImagePickerDialogue(context,controller);
            },
            child:   Center(
              child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    border: Border.all(color: ThemeColor.profileBgBorder),
                    borderRadius: BorderRadius.all(Radius.circular(90.r)),
                  ),
                  child: SizedBox(
                    child:
                    Obx(() => controller.isImage.value == true ? SizedBox(
                      width: 200,
                      child: CircleAvatar(
                        child:  Image.file(
                          controller.image!.absolute,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ):  Image.asset('${AppConstant.assestPath}profile_icon.png')),
                  )),
            ),
          ),
          15.hSpace,
          labelTextRegular(controller.userName.value, 15, ThemeColor.darkTextColor),
          25.hSpace,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColor.disableColor, width: 0.1),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Obx(() => ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                color: ThemeColor.lightTextColor.withOpacity(.2),
              ),
              itemCount: controller.listProfileData.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("OnTap""OnTap");
                  },
                  child: buildVehicleDetail(index,context,controller),
                );
              },
            )),
          )
        ]),
      ));
}

Widget buildVehicleDetail(int index, BuildContext context, ProfileController controller) {
  return InkWell(
    splashColor: ThemeColor.disableColor,
    onTap: () {
      if (index == 0) {
       print("Pos"+"Pos");
       Get.toNamed(Routes.myBlog,arguments:  {"isData": true,"title": "Test"});
      }
      if(index == 3){
        print("Logout""Logout");

      }
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(0.0),
      child: SizedBox(
          width: Get.width,
          child: Row(
            children: [
              Image(
                  image: AssetImage(AppConstant.assestPathIcon +
                      controller.listProfileData[index].icons) ),
              15.wSpace,
              Expanded(
                child: labelTextLight(controller.listProfileData[index].titles, 14,
                    ThemeColor.darkTextColor),
              ),
              controller.totalMyPost.value > 0 ?
              labelTextBold( controller.totalMyPost.value.toString(), 14, ThemeColor.lightTextColor) :
              0.hSpace
            ],
          )),
    ),
  );
}

void showImagePickerDialogue(context, ProfileController controller) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          content: SizedBox(
            height: Get.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.uploadImageFromCamera();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.uploadImageFromGallery();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Gallery"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget chooseImageDiloaug(BuildContext context, ProfileController controller){
  return Center(
    child: InkWell(
      onTap: () {
        showImagePickerDialogue(context,controller);
      },
      child: Container(
        height: Get.height * 0.2,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400)),
        child: controller.image != null
            ?
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(
              controller.image!.absolute,
              fit: BoxFit.fill,
            ))
            : const Center(child: Icon(Icons.camera_alt)),
      ),
    ),
  );
}