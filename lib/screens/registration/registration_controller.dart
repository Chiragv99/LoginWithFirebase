import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/auth/auth_services.dart';
import '../../routes/app_routes.dart';
import '../../uttils/appConstant.dart';
import '../../uttils/constant.dart';
import '../../widget/common_widget.dart';

class RegistrationController extends GetxController{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = RxBool(false);

  // Database Refrences
  late DatabaseReference userDatabase ;

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
  }

  void registerUser(BuildContext context) async{
    var userName = nameController.text.toString();
    var email = emailController.text.toString();
    var confirmPassword = confirmPasswordController.text.toString().trim();
    var password = passwordController.text.toString();

    if(userName.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Name!");
    }
    else if(email.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Email!");
    }else if(password.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Password!");
    }else if(confirmPassword.isEmpty){
      showSnakeBar(buildContext, "Please Enter Confirm Your Password!");
    }else if(password != confirmPassword){
      showSnakeBar(buildContext, "Your Password doesn't match!");
    }else{
      isLoading.value = true ;
      //addUserData();
      register(context,email,password,isLoading,userName);
    }
  }

  void redirectToLogin(){
    Get.offAndToNamed(Routes.loginScreen);
  }

  void addUserData() async{

    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final addUserDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserData);
    addUserDataRef.set({
      'id': id,
      'username': nameController.text.toString(),
      'email': emailController.text.toString()
    }).then((value) {
      isLoading.value = false;
      print("Post"+ "User Addedd");
    }).onError((error, stackTrace) {
      isLoading.value = false;
      print("Post"+ "Error");
    });

  }
}

void register(BuildContext context, String email, String password, RxBool isLoading, String userName) async{
  final message = await AuthService().registration(email: email, password: password,name: userName);

  if(message !=null){
    isLoading.value = false ;
  }

  if(message == success){
    showSnakeBar(buildContext,"Your registration is successful!");
    Get.offAndToNamed(Routes.loginScreen);
  }
  else{
    showSnakeBar(buildContext, message.toString());
    Get.offAndToNamed(Routes.loginScreen);
  }

}