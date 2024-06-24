import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/models/setMyBlogComment.dart';

import '../../../models/setMyBlogModel.dart';
import '../../../uttils/appConstant.dart';
import '../../../uttils/preferenceUtils.dart';
import '../../../uttils/uttils.dart';

class BlogDetailController extends GetxController{

  // For Store Data
  GetStorage getStorage;

  BlogDetailController({required this.getStorage});

  late SetMyBlogModel setMyBlogModel ;

  // For Show Loading
  RxBool isLoading = RxBool(false);

  // Database Refrences
  late DatabaseReference blogCommentDatabase ;


  // For User Data
  RxString userId = RxString("");
  RxString userName = RxString("");
  RxString profileImage = RxString("");

  final TextEditingController commentController = TextEditingController();

  // For Set Blog Data
  RxList<SetMyBlogComment> listBlogComment = RxList([]);

  @override
  void onInit() {
    super.onInit();
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    userName.value =  PreferenceUtils.getString(AppConstant.username,"");
    setMyBlogModel = Get.arguments;
    print("Title${setMyBlogModel.title}");
    getBlogDetail();
    print("Blog"+ "Blog Detail");
  }

   addBlogComment() {
    var blogComment = commentController.text.toString();
    if(blogComment.isEmpty){
      Utils().toastMessage("Please Add Blog Comment");
    }
    else{
      print("Comment" + "Comment");
      blogCommentDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageBlogComment);

      var currentTime = DateTime.now();
      isLoading.value = true;
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      blogCommentDatabase.child(id).set({
        'id': id,
        'blogId': setMyBlogModel.blogId,
        'userId': setMyBlogModel.userId,
        'commentUserId': userId.value,
        'comment': blogComment,
        'username':  userName.value.toString(),
        'blogtime': currentTime.toString(),
        'image' : ''
      }).then((value) {

        commentController.text = "";
        Utils().toastMessage("Comment Added Successfully!");
        isLoading.value = false;
        print("Comment"+ "Comment Addedd");
      }).onError((error, stackTrace) {
        isLoading.value = false;
        print("Post"+ "Error" + error.toString());
      });
    }
  }

  void getBlogDetail() async{

    isLoading.value = true;

    DatabaseReference  blogCommentDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageBlogComment);

    Query query = blogCommentDatabase.orderByChild("blogId").equalTo(setMyBlogModel.blogId);
    DataSnapshot event = await query.get();

    if(event.value != null){
      listBlogComment.value.clear();
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {

        var blogId = value['blogId'].toString();
        var blogTime = value['blogtime'].toString();
        var comment = value['comment'].toString();
        var commentUserId = value['commentUserId'].toString();
        var id = value['id'].toString();
        var image = value['image'].toString();
        var userId = value['userId'].toString();
        var username = "";

        if(this.userId.value == commentUserId){
          username = "You";
        }
        else{
           username = value['username'].toString();
        }

        DateTime dateTime = DateTime.parse(blogTime);
        var parseDate = "";
         parseDate = getFilterDateTime(dateTime,parseDate);

        SetMyBlogComment setMyBlogComment = SetMyBlogComment(id,blogId,userId,commentUserId,comment,parseDate,image,username);
        listBlogComment.value.add(setMyBlogComment);
        print("Comment"+ comment + " "+listBlogComment.length.toString());
      });
      if(values !=null){
       // listBlogComment.clear();
        isLoading.value = false;
        print("Data"+ "Has Data");
      }else{
        listBlogComment.value.clear();
        isLoading.value = false;
        print("Data"+ "No Data");
      }
    }else{
      listBlogComment.value.clear();
      isLoading.value = false;
      print("Data"+ "No Data");
    }
  }
}