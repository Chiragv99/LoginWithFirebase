import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:intl/intl.dart';

import '../../models/setMyBlogModel.dart';
import '../../routes/app_routes.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';

class HomeController extends GetxController{

  RxBool isLoading = RxBool(false);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Database Refrences
  late DatabaseReference blogDatabase ;

  int selectedIndex = 0;
  RxString filterTag = "".obs;



  // For Set Blog Data
  RxList<SetMyBlogModel> listAllBlog = RxList([]);
  late SetMyBlogModel setMyBlogModel ;

  RxString userId = RxString("");

  @override
  void onInit() async{
    super.onInit();
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    isLoading = RxBool(false);
    blogDatabase = FirebaseDatabase.instance.ref('Blog');
    getAllUserPost();
  }

  deleteData() async{
    FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName).remove();
  }

   onItemTapped(int index) {
    selectedIndex = index;
  }

  redirectToBlogDetail(SetMyBlogModel setMyBlogModel){
    Get.toNamed(Routes.blogDetail,arguments:  setMyBlogModel);
  }

  redirectToProfile(SetMyBlogModel setMyBlogModel){
    Get.toNamed(Routes.otherprofile,arguments: {"name": setMyBlogModel.userName,"userId": setMyBlogModel.userId,"profileImage": setMyBlogModel.profileImage});
  }

  getAllUserPost() async{
    isLoading.value = true;
    blogDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

    Query query = blogDatabase;
    DataSnapshot event = await query.get();

    if(event.value != null){
      listAllBlog.value.clear();
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {

        var userId = value['userId'].toString();
        var blogTime = value['time'].toString();
        var id = value['id'].toString();
        var title = value['title'].toString();
        var desc = value['desc'].toString();
        var image = value['image'].toString();
        var username = value['name'].toString();
        var profileImage = value['profileImage'].toString();
        var totalLike = [] ;
        if(value['like'] != null){
          totalLike = value['like'];
        }

        DateTime dateTime = DateTime.parse(blogTime);
        var parseDate = "";
         parseDate = getFilterDateTime(dateTime,parseDate);

        SetMyBlogModel setMyBlogModel = SetMyBlogModel(userId, parseDate, id, title, desc, image,username,profileImage,totalLike.length,0,totalLike);
        listAllBlog.value.add(setMyBlogModel);
      });
      if(values !=null){
        isLoading.value = false;
        print("Data"+ "Has Data");
      }else{
        listAllBlog.value.clear();
        isLoading.value = false;
        print("Data"+ "No Data");
      }
    }else{
      listAllBlog.value.clear();
      isLoading.value = false;
      print("Data"+ "No Data");
    }
  }

}

DateTime changeDateFormate(String strDate) {
  DateTime parseDate = DateFormat("yyyy-MM-dd").parse(strDate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('dd-MM-yyyy');
  var outputDate = outputFormat.format(inputDate);
  return DateFormat("dd-MM-yyyy").parse(outputDate).toLocal();
}
