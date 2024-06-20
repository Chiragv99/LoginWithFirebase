import 'dart:async';
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:intl/intl.dart';

import '../../models/setMyBlogModel.dart';

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


  @override
  void onInit() async{
    super.onInit();
    isLoading = RxBool(false);
    blogDatabase = FirebaseDatabase.instance.ref('Blog');
  }

  deleteData() async{
    FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName).remove();
  }

   onItemTapped(int index) {
    selectedIndex = index;
  }

  getFilterDateTime(DateTime blogDate) {
    DateTime previousDate = changeDateFormate(DateTime.now().toString())
        .subtract(const Duration(days: 1));
    if(changeDateFormate(blogDate.toString()) == changeDateFormate(
        DateTime.now().toString())){
      filterTag.value = "Today";
      filterTag.value = DateFormat('EEEE dd MMM').format(
          DateTime.parse(blogDate.toString()));
    }else if(changeDateFormate(blogDate.toString()) == previousDate){
      filterTag.value = "YesterDay";
    }else {
      filterTag.value = DateFormat('EEEE dd MMM').format(
          DateTime.parse(blogDate.toString()));
    }
    return filterTag.value;
  }

  DateTime changeDateFormate(String strDate) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(strDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);
    return DateFormat("dd-MM-yyyy").parse(outputDate).toLocal();
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

        print("UserName" + username.toString());



        var now = new DateTime.now();
        var parseDate = getFilterDateTime(now);

        print("ParseDate"+ parseDate.toString());

        SetMyBlogModel setMyBlogModel = SetMyBlogModel(userId, blogTime, id, title, desc, image,username,profileImage);
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


getFilterDateTime(String strBlogDate,String parseDate) {
  DateTime previousDate = changeDateFormate(DateTime.now().toString())
      .subtract(const Duration(days: 1));
  if(changeDateFormate(strBlogDate.toString()) == changeDateFormate(
      DateTime.now().toString())){
    return parseDate = "Today";
    print("Date"+ "Today");
  }else if(changeDateFormate(strBlogDate.toString()) == previousDate){
    parseDate = "YesterDay";
    return print("Date"+ "YesterDay");
  }else {
    return parseDate = DateFormat('EEEE dd MMM').format(
        DateTime.parse(strBlogDate));
  }
}
