import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/login/login_controller.dart';
import 'package:loginwithfirebase/uttils/validation.dart';
import 'package:loginwithfirebase/widget/common_widget.dart';

import '../../uttils/appConstant.dart';
import '../../uttils/theme_color.dart';
import '../../widget/round_button.dart';

class LoginScreen extends GetView<LoginController>{
   LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body:
       Container(
         color: Colors.grey.shade300,
         child:   Column(
           children: <Widget>[
             Flexible(
                 flex: 25,
                 child:
                 Container(
                   alignment: Alignment.center,
                   child: Column(
                       children: [
                         const SizedBox(
                           height: 300,
                         ),
                         Text("Login",
                             style: ThemeColor.textStyle12px
                                 .copyWith(fontSize: 20, color: Colors.black
                             ,fontWeight: FontWeight.bold)),
                         const SizedBox(height: 30,),
                         SizedBox(
                             width: MediaQuery.of(context).size.width - 100,
                             child:  TextFormField(
                               controller: controller.emailController,
                               obscureText: false,
                               enabled: true,
                               textInputAction: TextInputAction.next,
                               autovalidateMode: AutovalidateMode.onUserInteraction,
                               decoration: inputDecorationWithBorderWithIcon('Email',
                                   "${AppConstant.assestPath}sms.png",
                                   ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor),
                               validator: (email){
                                 return  Validation.validateEmail(email);
                               },
                             )
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                         SizedBox(
                           width: MediaQuery.of(context).size.width - 100,
                           child: TextFormField(
                               controller: controller.passwordController,
                               obscureText: true,
                               enabled: true,
                               decoration:
                               inputDecorationWithBorderWithIcon('Password',
                                   "${AppConstant.assestPath}lock.png",
                                   ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor)
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Padding(padding: const EdgeInsets.only(right: 45,top: 10),child:
                             labelTextBold("Forgot Password?",6,Colors.grey.shade800)
                              ),],
                         ),
                         const SizedBox(
                           height: 30,
                         ),
                         Obx(() => controller.isLoading.value == true ? const CircularProgressIndicator() :    SizedBox(
                           width: 200,
                           child:  RoundedButton(
                             isLoading: false,
                             isEnable: true,text: "Login",onTap: controller.processToLogin,
                             fontSize: AppConstant.buttonSize,
                           ),
                         )),
                         const SizedBox(
                           height: 10,
                         ),
                       ]
                   ),
                 )),
              Flexible(
                 flex: 1,
                 child:
                 RichText(
                   text: TextSpan(
                       text: 'Do not have Account?'.tr,
                       style: ThemeColor.textStyle14px.copyWith(
                           fontSize: 8.sp,
                           color: ThemeColor.darkTextColor,
                           fontWeight: FontWeight.w300,
                       fontFamily: AppConstant.labelFrontBold),
                       children: [
                         TextSpan(
                             text:  '  SignUp Here',
                             style: ThemeColor.textStyle14px
                                 .copyWith(
                                 fontSize: 8.sp,
                                 color: Colors.red,
                                 fontWeight:
                                 FontWeight.w600),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                controller.redirectToSignUp();
                               }),
                       ]),
                 )
                 )
           ],
         ) ,
       ),
     );
  }
}