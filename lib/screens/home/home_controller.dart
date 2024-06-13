import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';

class HomeController extends GetxController{

  RxBool isLoading = RxBool(false);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Database Refrences
  late DatabaseReference blogDatabase ;

  int selectedIndex = 0;

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

     databaseReference.child("chirag@gmail.com").onValue.listen((event) {
       print("counter update "+ event.snapshot.value.toString());

     });
   }
  deleteData() async{
    FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName).remove();
  }

   onItemTapped(int index) {
    selectedIndex = index;
  }
}