import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/registration/registration_controller.dart';

import '../../uttils/appConstant.dart';
import '../../uttils/theme_color.dart';
import '../../uttils/validation.dart';
import '../../widget/common_widget.dart';
import '../../widget/round_button.dart';

class RegistrationScreen extends GetView<RegistrationController>{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(child:
     Container(
       color: Colors.grey.shade300,
       child: Column(
         children:  <Widget>[
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
                      Text("Registration",
                          style: ThemeColor.textStyle12px
                              .copyWith(fontSize: 20, color: Colors.black
                              ,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child:  TextFormField(
                            controller: controller.nameController,
                            obscureText: false,
                            enabled: true,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: inputDecorationWithBorderWithIcon('Name',
                                "${AppConstant.assestPath}sms.png",
                                ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor),
                            validator: (email){
                              return  Validation.validateInputText(email,"Name");
                            },
                          )
                      ),
                      SizedBox(height: 10,),
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
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child:  TextFormField(
                            controller: controller.passwordController,
                            obscureText: false,
                            enabled: true,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: inputDecorationWithBorderWithIcon('Password',
                                "${AppConstant.assestPath}lock.png",
                                ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor),
                            validator: (password){
                              return  Validation.validateInputText(password,"Password");
                            },
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child:  TextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: false,
                            enabled: true,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: inputDecorationWithBorderWithIcon('Confirm Password',
                                "${AppConstant.assestPath}lock.png",
                                ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor),
                            validator: (confirmpassword){
                              return  Validation.validateConfirmPassword(controller.passwordController.text,controller.confirmPasswordController.text);
                            },
                          )
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(height: 30,),
                      Obx(() => controller.isLoading.value == true ?  const CircularProgressIndicator() : SizedBox(
                        width: 200,
                        child:  RoundedButton(
                          isLoading: false,
                          isEnable: true,text: "Register",onTap: (){
                          controller.registerUser(context);
                        },
                          fontSize: AppConstant.buttonSize,
                        ),
                      ),)
                    ],
                  ),
                )),
           Flexible(
               flex: 1,
               child:
               RichText(
                 text: TextSpan(
                     text: 'Already have Account?'.tr,
                     style: ThemeColor.textStyle14px.copyWith(
                         fontSize: 8.sp,
                         color: ThemeColor.darkTextColor,
                         fontWeight: FontWeight.w300,
                         fontFamily: AppConstant.labelFrontBold),
                     children: [
                       TextSpan(
                           text:  '  Login Here',
                           style: ThemeColor.textStyle14px
                               .copyWith(
                               fontSize: 8.sp,
                               color: Colors.red,
                               fontWeight:
                               FontWeight.w600),
                           recognizer: TapGestureRecognizer()
                             ..onTap = () {
                               controller.redirectToLogin();
                             }),
                     ]),
               )
           )
         ],
       ),
     )),
   );
  }
}