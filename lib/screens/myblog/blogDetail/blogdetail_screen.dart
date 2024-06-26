import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loginwithfirebase/models/setMyBlogComment.dart';

import '../../../uttils/appConstant.dart';
import '../../../uttils/theme_color.dart';
import '../../../uttils/validation.dart';
import '../../../widget/common_widget.dart';
import 'blogdetail_controller.dart';

class BlogDetailScreen extends GetView<BlogDetailController>{
  BlogDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: topHeaderWithBackIcon("Blog Detail".tr),
      body:   getMainContent(context)));
  }

  Widget getMainContent(BuildContext context){
   return Padding(padding: const EdgeInsets.only(left: 15,right: 10,bottom: 10),child:
     Stack(
     children: <Widget>[
       Padding(padding: EdgeInsets.only(bottom: Get.height / 9,left: 10,right: 10),child:
       Column(
         children: [
           Expanded(child:
           SingleChildScrollView(
             padding: EdgeInsets.all(10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const SizedBox(
                   height: 10,
                 ),
                 SizedBox(
                   width: Get.width,
                   height: 300,
                   child: Image.network(controller.setMyBlogModel.image!,fit: BoxFit.fitWidth,),
                 ),
                 const SizedBox(
                   height: 10,
                 ),
                 labelTextBold(controller.setMyBlogModel.title, 8.sp, Colors.grey),
                 const SizedBox(
                   height: 10,
                 ),
                 labelTextRegular(controller.setMyBlogModel.desc, 5.sp, Colors.black),
                 Obx(() => controller.isLoading.value == true ? const CircularProgressIndicator() :  getCommentHeader(context))

               ],
             ),
           ))
         ],
       ),),
       Align(
         alignment:  Alignment.bottomCenter,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             SizedBox(
                 width: MediaQuery.of(context).size.width - 100,
                 child:  TextFormField(
                   controller: controller.commentController,
                   obscureText: false,
                   enabled: true,
                   textInputAction: TextInputAction.next,
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                   decoration: inputDecorationWithBorderWithIcon('Add Comment here',
                       "${AppConstant.assestPath}sms.png",
                       ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor),
                   validator: (email){
                     return  Validation.validateInputText(email,"Comment");
                   },
                 )
             ),

             SizedBox(
               width: 50,
               child:
               InkWell(
                 onTap: () {
                   controller.addBlogComment();
                 },
                 child:  Image.asset("${AppConstant.assestPath}comment.png"),
               ),
             )
           ],
         ),
       )
     ],
   ));
  }
 Widget getCommentWidget(BlogDetailController controller, BuildContext context) {
    return
      SizedBox(
        width: Get.width - 50,
        child:  ListView.builder(
            shrinkWrap: true,
            itemCount: controller.listBlogComment.length,
            itemBuilder: (BuildContext context, int index){
              return setCommentWidget(controller.listBlogComment[index].comment!!,controller,controller.listBlogComment[index]);
              Text(controller.listBlogComment[index].comment!!);
            }),
      );
 }

  getCommentHeader(BuildContext context) {
    return
    Visibility(
      visible: controller.listBlogComment.isNotEmpty,
        child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        labelTextBold("Comments", 5.sp, Colors.red.shade200),
        getCommentWidget(controller,context)
      ],
    ));
  }
}
Widget setCommentWidget(String strComment, BlogDetailController controller, SetMyBlogComment listBlogComment){
return  SizedBox(
  width: Get.width /2,
  child: Padding(padding: const EdgeInsets.only(top: 0,left: 0,right: 0),child:
  Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
    elevation: 4,
    child:
    Padding(
      padding: const EdgeInsets.only(left: 5,right: 5),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 30,
                  height: 30,
                  child: controller.profileImage == null || controller.profileImage == "" ? CircleAvatar(child: Image.asset("${AppConstant.assestPath}userimage.png")) : CircleAvatar(child: Image.network(controller.profileImage.value))),
              const SizedBox(width: 10,),
              Text(listBlogComment.username!!,style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
            ],
          ),
          Text(listBlogComment.blogTime.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 8),),
        ]),
          const SizedBox(height: 5,),
          labelTextRegular(strComment, 4.sp, Colors.black)
        ],
      ),
    ),
  ),
  ),
);

}