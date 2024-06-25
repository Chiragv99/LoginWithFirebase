
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loginwithfirebase/screens/profile/followrequest/followrequest_controller.dart';

import '../../../uttils/appConstant.dart';
import '../../../uttils/theme_color.dart';
import '../../../widget/common_widget.dart';
import '../../../widget/round_button.dart';

class FollowRequestScreen extends GetView<FollowRequestController> {

  @override
  Widget build(BuildContext context) {
     return  Container(
       decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
       child: Scaffold(
         backgroundColor: ThemeColor.backgroundColor,
         appBar: topHeaderWithBackIcon("Follow Request"),
         body: SafeArea(
             child: Column(
               children: [ 
                labelTextLight("All Request", 4.sp, Colors.black),
                 ListView.builder(
                    shrinkWrap: true,
                     itemCount: 10,
                     itemBuilder: (context,index){
                     return Container(
                       margin: const EdgeInsets.only(top: 0, right: 16, left: 16,bottom: 10),
                       padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                       child:  setFollowRequestData(),
                     );
                 })
               ],
             )),
       ),
     );
  }
}
Widget setFollowRequestData(){
  return Padding(padding: const EdgeInsets.only(top: 0,left: 0,right: 0),child:
  Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
    elevation: 4,
    child:
    Padding(
      padding: const EdgeInsets.all(10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){

            },
            child:  Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Flex(
                  direction: Axis.horizontal,children: [
                  SizedBox(
                      width: 30,
                      height: 30,
                      child:  CircleAvatar(
                          child: Image.asset("${AppConstant.assestPath}userimage.png"))),
                  Text("Username"),
                  SizedBox(
                    width: 150,
                    child:  RoundedButton(
                      isEnable: true,
                      text: "Accept",
                      fontSize: AppConstant.buttonSize,
                      onTap: () {

                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child:  RoundedButton(
                      isEnable: true,
                      text: "Reject",
                      fontSize: AppConstant.buttonSize,
                      onTap: () {

                      },
                    ),
                  )
                ],),

              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  ));
}