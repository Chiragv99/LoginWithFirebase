import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/auth/auth_services.dart';
import 'package:loginwithfirebase/widget/common_widget.dart';
import '../../routes/app_routes.dart';
import '../../uttils/appConstant.dart';
import '../../uttils/constant.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/validation.dart';

class LoginController extends GetxController{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = RxBool(false);



  // For Store Data
  GetStorage getStorage;

  LoginController({required this.getStorage});


  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
  }

  void redirectToLogin(){
  }

  void redirectToSignUp(){
    Get.offAndToNamed(Routes.signupScreen);
  }

  void processToLogin() async{

    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();


    if(email.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Email!");
    }else if(Validation.validateEmail(email) != null){
      showSnakeBar(buildContext, "Please Enter Valid EmailId");
    }else if(password.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Password!");
    }else{
      isLoading.value = true;
     var message =  await AuthService().loginWithFirebase(email, password);

     if(message == success){
       isLoading.value = false;
       final FirebaseAuth auth = FirebaseAuth.instance;
       final User? user = auth.currentUser;
       final uid = user?.uid;

         PreferenceUtils.setString(AppConstant.userId,uid!)!;
         PreferenceUtils.setBool(AppConstant.keepMeLogin,true)!;
         saveUserName(uid);
         showSnakeBar(buildContext,"Login Successfully!");
         Get.offAndToNamed(Routes.tabBarScreen);
     }
     else{
       isLoading.value = false;
       showSnakeBar(buildContext, message.toString());
     }
    }
  }

  void saveUserName(String uid) {
    final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserData);
      blogDataRef.child(uid).once().then((value) => {
       print("UserName"+ value.snapshot.child("username").value.toString()),
       PreferenceUtils.setString(AppConstant.username,value.snapshot.child("username").value.toString()!),
    }).onError((error, stackTrace) => {

    });
  }
}