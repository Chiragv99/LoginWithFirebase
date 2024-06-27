import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/home/home_controller.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/setMyBlogModel.dart';

class HomeScreen extends GetView<HomeController>{

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
       onFocusGained: (){
        // controller.readData();
         controller.getAllUserPost();
       },
      onFocusLost: (){},
      child:   MaterialApp(
    home: Scaffold(
    appBar: AppBar(
    title: const Text('Firebase Data Example'),
    ),
    body:  Obx(() => controller.isLoading.value == true ? loadShimmer() : getAllPost(controller,context)),
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
  void getUserProfileImage(){
  }


  getAllPost(HomeController controller, BuildContext context) {
    return
      ListView.builder(
        shrinkWrap: false,
        itemCount: controller.listAllBlog.value.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
            //  SetMyBlogModel setMyBlogModel = controller.listAllBlog[index];
           //
              print("Post$index");
            },
            child:  Container(
              margin: const EdgeInsets.only(top: 0, right: 16, left: 16,bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child:  setAllPostData(controller.listAllBlog.value[index],context,controller,index),
            ),
          );
        });
  }
}
Widget setAllPostData(SetMyBlogModel setMyBlogModel, BuildContext context, HomeController controller, int index){
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
          InkWell(
            onTap: (){
              print("Tap"+ "Profile" +setMyBlogModel.userId.toString());
              controller.redirectToProfile(setMyBlogModel);
            },
            child:  Row(
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
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              print("Tap"+ "Column");
              controller.redirectToBlogDetail(setMyBlogModel);
            },
            child:    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(setMyBlogModel.title.toString(), maxLines: 1 ,style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 10,
                ),
                Text(setMyBlogModel.desc.toString(),maxLines: 2),
                SizedBox(
                  width: Get.width,
                  height: Get.height /6,
                  child:   Image.network(setMyBlogModel.image!,fit: BoxFit.fitWidth,),
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                getLikeCommentShareWidget(setMyBlogModel,controller)
              ],
            ),
          )
        ],
      ),
    ),
  ));
}

Widget getLikeCommentShareWidget(SetMyBlogModel setMyBlogModel, HomeController controller){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: (){
          print("Like"+ "Like");
          addPostLike(setMyBlogModel,controller);
        },
        child: Row(
          children: [
              Icon( setMyBlogModel.isLiked == false ?
              FontAwesomeIcons.thumbsUp :  FontAwesomeIcons.solidThumbsUp,
            size: 18,),
            const SizedBox(width: 5,),
            Text(setMyBlogModel.totalLikes.toString())
          ],
        ),
      ),
      GestureDetector(
        onTap: (){

        },
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.comment,
              size: 18,),
            const SizedBox(width: 5,),
            Text(setMyBlogModel.totalComments.toString())
          ],
        ),
      ),
      GestureDetector(
        onTap: (){

        },
        child: const Row(
          children: [
            Icon(FontAwesomeIcons.bookmark,
              size: 18,),
            SizedBox(width: 5,)
          ],
        ),
      ),
      GestureDetector(
        onTap: (){

        },
        child: const Row(
          children: [
            Icon(FontAwesomeIcons.shareAlt,
              size: 18,),
            SizedBox(width: 5,)
          ],
        ),
      )
    ],
  );
}

void addPostLike(SetMyBlogModel setMyBlogModel, HomeController controller) {

  var blogLike = [];
  blogLike = setMyBlogModel.blogLikeId;
  final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

  var tempOutput = List<String>.from(blogLike);

  if(tempOutput.contains(controller.userId.value)){
   // tempOutput.removeWhere((item) => item == controller.userId.value);
    tempOutput.removeAt(0);
  }else{
    tempOutput.add(controller.userId.value);
  }

  print("Contain${tempOutput.contains(controller.userId.value)}");

  print("Blog$tempOutput");
  blogDataRef.child(setMyBlogModel.blogId).update({
    'like': tempOutput
  }).then((value) {
   print("AddLike"+ "Add Like");
  }).onError((error, stackTrace) {
    print("AddLike$error");
  });
}
loadShimmer(){
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemCount: 5, // Adjust the count based on your needs
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
            height: 200,
            width: 200,
            color: Colors.white,
          ),
        );
      },
    ),
  );
 }