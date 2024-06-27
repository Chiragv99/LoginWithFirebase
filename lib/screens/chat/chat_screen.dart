import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loginwithfirebase/models/setChatModel.dart';
import 'package:loginwithfirebase/screens/chat/chat_controller.dart';

import '../../uttils/appConstant.dart';
import '../../uttils/theme_color.dart';
import '../../widget/common_widget.dart';

class ChatScreen extends  GetView<ChatController>{
  ChatScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
      child: Scaffold(
        backgroundColor: ThemeColor.backgroundColor,
        appBar: topHeaderWithBackIcon(controller.receiverUserName.value.tr),
        body: Stack(
          children: [
            Obx(() => controller.isLoading.value == true ? const CircularProgressIndicator() : getUserChat(controller,context)),
            Align(
              alignment: Alignment.bottomCenter,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child:  TextFormField(
                        controller: controller.chatMessageController,
                        obscureText: false,
                        enabled: true,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: inputDecorationWithBorderWithIcon('Add Message here',
                            "${AppConstant.assestPath}sms.png",
                            ThemeColor.textFieldBGStrokeColor, ThemeColor.textFieldBGColor),
                      )
                  ),
                  SizedBox(
                    width: 50,
                    child:
                    InkWell(
                      onTap: () {
                        controller.sendChatMessage();
                      },
                      child:  Image.asset("${AppConstant.assestPath}comment.png"),
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    ));
  }

  getUserChat(ChatController controller, BuildContext context) {
    return ListView.builder(
        shrinkWrap: false,
        itemCount: controller.listChat.value.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: const EdgeInsets.only(top: 0, right: 16, left: 16,bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child:  setChatData(controller.listChat.value[index],context,controller),
          );
        });
  }

  setChatData(SetChatModel setChatModel, BuildContext context, ChatController controller) {
    return Align(
      alignment: setChatModel.isSend == true ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 10.0),
        decoration:  BoxDecoration(
         color: setChatModel.isSend == true ? Colors.grey : Colors.red,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
        ),
        child: Text(
         setChatModel.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}