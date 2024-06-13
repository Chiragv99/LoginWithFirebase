import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/splash/splash_controller.dart';

import '../../uttils/colors.dart';
import '../../widget/round_button.dart';


class SlashPage extends GetView<SplashController>{
  const SlashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       body: SafeArea(
       child:
       Container(
         decoration: const BoxDecoration(
         image: DecorationImage(
         image: AssetImage('assets/images/landing.png'), fit: BoxFit.cover)),
         child:  Column(
           children: [
             Spacer(),
             Padding(padding: EdgeInsets.only(bottom: 30),child: getIntroductionScreenWidget(context,controller)),
           ],
         )
       ))
     );
  }
}
Widget getIntroductionScreenWidget(BuildContext context, SplashController controller){
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 20
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  'Welcome to Veggie Fresh',
  style: Theme.of(context).textTheme.displaySmall!.copyWith(
  color: kTextColor,
  fontWeight: FontWeight.w600,
  ),
  ),
  const SizedBox(height:  30),
  Text(
  'We have more than 10,000+ food available for all of you.',
  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
  color: kTextColorAccent,
  ),
  ),
  const SizedBox(height: 40),
    Center(
      child: RoundedButton(
        isEnable: true,
        text: 'Get Started',
        fontSize: 10,
        onTap: () {
          print("GetStart"+ "GetStart");
          controller.redirectToIntroScreen();
        },
        width: ScreenUtil().setSp(100),
        height: ScreenUtil().setSp(30),
      ),
    )
  ,
  ],
  ),
  )
  );
}