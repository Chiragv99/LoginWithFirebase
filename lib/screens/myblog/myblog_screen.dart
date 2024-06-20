import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/models/setMyBlogModel.dart';
import 'package:loginwithfirebase/screens/myblog/myblog_controller.dart';

import '../../uttils/appConstant.dart';



class MyBlogScreen extends GetView<MyBlogController>{
  MyBlogScreen({Key? key}) : super(key: key);

  var userId = "";
  
 late BuildContext context;

  @override
  void onInit() {

  }


  @override
  Widget build(BuildContext context) {
    return FocusDetector(
       onFocusGained: (){
         controller.getMyBlog();
       },
        child:   MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Firebase Data Example'),
            ),
            body:  Obx(() => controller.isLoading.value == true ? const CircularProgressIndicator() : getMyBlog(controller,context)),
          ),
        ));

  }

   getMyBlog(MyBlogController controller, BuildContext context) {
   return ListView.builder(
       shrinkWrap: false,
       itemCount: controller.listMyBlog.value.length,
       itemBuilder: (BuildContext context, int index){
       return Container(
         margin: const EdgeInsets.only(top: 0, right: 16, left: 16,bottom: 10),
         padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
         child:  setBlocData(controller.listMyBlog.value[index],context,controller),
       );
   });
  }
}

Widget setBlocData(SetMyBlogModel setMyBlogModel, BuildContext context, MyBlogController controller){
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
              Text(setMyBlogModel.userName.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                       print("Edit"+"Edit" + setMyBlogModel.blogId);
                       controller.editBlog(setMyBlogModel);
                    },
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child:   Image.asset("${AppConstant.assestPathIcon}edit.png"),
                    ),
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap: (){
                      showDeleteBlogAlert(context,controller,setMyBlogModel.blogId);
                      print("print"+ "Delete" + setMyBlogModel.blogId);
                    },
                    child:   SizedBox(
                      width: 25,
                      height: 25,
                      child:   Image.asset("${AppConstant.assestPathIcon}ic_delete.png"),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(setMyBlogModel.title.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          Text(setMyBlogModel.desc.toString()),
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
Widget setLoading(){
  return SizedBox(
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

  showDeleteBlogAlert(BuildContext context, MyBlogController controller, String blogId){
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
       controller.deleteBlog(blogId);
      // controller.requestToLogout();
       Get.back();
     },
   );

   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: const Text("Alert"),
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(10.r))
     ),
     content: const Text("Are You Sure want to Delete?"),
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