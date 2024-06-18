import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:intl/intl.dart';

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

  @override
  void onInit() async{
    super.onInit();
    isLoading = RxBool(false);
    blogDatabase = FirebaseDatabase.instance.ref('Blog');
    readData();

  }

  void addStudent() async{

    String id = DateTime.now().microsecondsSinceEpoch.toString();
    var studentData = FirebaseDatabase.instance.ref('${AppConstant.firebaseStorageName}/hamid/$id');

    var firstName = firstNameController.text.toString().trim();
    var lastName = lastNameController.text.toString().trim();
    var email = emailController.text.toString().trim();
    var phone =  phoneController.text.toString().trim();

    await Future.value(studentData).then((value) async{
       studentData.set({
         "name": "$firstName $lastName",
         "email": email,
         "phone": phone
       }).then((value) => {
         print("Data"+ "Added")
       }).onError((error, stackTrace) => {
         print("Data"+  error.toString())
       });
    });
  }

   readData() async{

     DatabaseReference databaseReference =  FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserData);
     Query query = databaseReference.orderByChild('1718263629505252');

     query.once().then((value) => {
     if (value != null) {
         print('Data')
       //  print(value.snapshot.child("email").value)
       } else {
        print('No data found.')
     }
     }).onError((error, stackTrace) => {

     });


     var blogDate = getFilterDateTime("2024-06-10 07:01:31.432435Z");
     print("BlogDate"+ blogDate +" "+ DateTime.now().toUtc().toString());

   }
  deleteData() async{
    FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName).remove();
  }

   onItemTapped(int index) {
    selectedIndex = index;
  }

  getFilterDateTime(String blogDate) {
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
}