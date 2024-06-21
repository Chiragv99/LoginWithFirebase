import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/home/home_controller.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';

import '../../models/setMyBlogModel.dart';

class HomeScreen extends GetView<HomeController>{

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
       onFocusGained: (){
        // controller.readData();
       //  controller.getAllUserPost();
       },
      onFocusLost: (){},
      child:   MaterialApp(
    home: Scaffold(
    appBar: AppBar(
    title: const Text('Firebase Data Example'),
    ),
    body:  Obx(() => controller.isLoading.value == true ? const CircularProgressIndicator() : getAllPost(controller,context)),
    ),
    ));
  }

 Widget setLoading(){
    return Container(
      width: Get.width,
      height: Get.height,
      child:
      const Center(
        child:Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text("Please Wait..")
          ],
        ) ,
      ),
    );
  }
  void getUserProfileImage(){
    var profileImage = "";
  }


  getAllPost(HomeController controller, BuildContext context) {
    return ListView.builder(
        shrinkWrap: false,
        itemCount: controller.listAllBlog.value.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              SetMyBlogModel setMyBlogModel = controller.listAllBlog[index];
              controller.redirectToBlogDetail(setMyBlogModel);
              print("Post"+ index.toString());
            },
            child:  Container(
              margin: const EdgeInsets.only(top: 0, right: 16, left: 16,bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child:  setAllPostData(controller.listAllBlog.value[index],context,controller),
            ),
          );
        });
  }
}
Widget setAllPostData(SetMyBlogModel setMyBlogModel, BuildContext context, HomeController controller){
  return Padding(padding: const EdgeInsets.only(top: 0,left: 0,right: 0),child:
  Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
    elevation: 4,
    child:
    Padding(
      padding: const EdgeInsets.all(10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 30,
                      height: 30,
                      child: setMyBlogModel.profileImage == null || setMyBlogModel.profileImage == "" ? CircleAvatar(child: Image.asset("${AppConstant.assestPath}userimage.png")) : CircleAvatar(child: Image.network(setMyBlogModel.profileImage!!))),
                  const SizedBox(width: 10,),
                  Text(setMyBlogModel.userName.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
                ],
              ),
              Text(setMyBlogModel.blogTime.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(setMyBlogModel.title.toString(), maxLines: 1 ,style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          Text(setMyBlogModel.desc.toString(),maxLines: 2),
          SizedBox(
            width: Get.width,
            height: Get.height /6,
            child:   Image.network(setMyBlogModel.image!,fit: BoxFit.fitWidth,),
          )
        ],
      ),
    ),
  ));
}