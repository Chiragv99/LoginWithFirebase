import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/post/post_controller.dart';
import 'package:loginwithfirebase/widget/common_widget.dart';

import '../../uttils/appConstant.dart';
import '../../widget/round_button.dart';

class PostScreen extends GetView<PostController>{
  PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text("Upload Blogs"),
         centerTitle: true,
       ),
       body:
       SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              PostInputTextFormFiled(context,"Title*", "Enter Title",controller.titleController,1,true),
              const SizedBox(
                height: 20,
              ),
              PostInputTextFormFiled(context,"Description*", "Enter Description",controller.descController,5,true),
              const SizedBox(
                height: 20,
              ),
              PostInputTextFormFiled(context,"URL", "Enter URL",controller.blogUrl,1,false),
              const SizedBox(
                height: 20,
              ),
              Obx(() => controller.isLoading.value == true ? const CircularProgressIndicator() : Container()),
              const SizedBox(
                height: 20,
              ),
              chooseImageDiloaug(context),
              const SizedBox(height: 20,),
              Obx(() => controller.isLoading.value == true ? SizedBox(
                width: 200,
                child:  RoundedButton(
                  isLoading: false,
                  isEnable: controller.isLoading.value ? false : true,text: "Upload Blog",onTap: controller.addBlog,
                  fontSize: AppConstant.buttonSize,
                ),
              ):  SizedBox(
                width: 200,
                child:  RoundedButton(
                  isLoading: false,
                  isEnable: true,text: "Upload Blog",onTap: controller.addBlog,
                  fontSize: AppConstant.buttonSize,
                ),
              )),
            ],
          ),
        ),
       ));
  }

  void showImagePickerDialogue(context) {
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

  Widget chooseImageDiloaug(BuildContext context){
    return  Center(
      child: InkWell(
        onTap: () {
          showImagePickerDialogue(context);
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
}