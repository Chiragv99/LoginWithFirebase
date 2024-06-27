import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/models/setChatModel.dart';

import '../../uttils/appConstant.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';

class ChatController extends GetxController{


  // For Show Loading
  RxBool isLoading = RxBool(false);

  // Receiver Data
  RxString receiverUserName = RxString("");
  RxString senderUserName = RxString("");
  RxString receiverUserId = RxString("");
  RxString senderUserId = RxString("");
  RxString message = RxString("");
  RxString chatDateTime = RxString("");

  final TextEditingController chatMessageController = TextEditingController();

  // Database Refrences
  late DatabaseReference blogDatabase ;
  RxList<SetChatModel> listChat = RxList([]);

  RxString userId = RxString("");

  @override
  void onInit() async{
    super.onInit();
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    blogDatabase = FirebaseDatabase.instance.ref();
    receiverUserName.value = Get.arguments["receiverName"];
    receiverUserId.value = Get.arguments["receiverId"];
    senderUserId.value = Get.arguments["senderId"];
    getChatMessage();
    print("ChatData${"${receiverUserId.value} ${senderUserId.value} ${receiverUserName.value}"}");
  }

  sendChatMessage() async{
    var chatMessage = chatMessageController.text.toString();
    if(chatMessage.isEmpty){
      Utils().toastMessage("Please Enter Message First!");
    }
    else{

      var timeSend = DateTime.now().toUtc().toIso8601String();
      var senderId = senderUserId.value;
      var receiverId = receiverUserId.value;
      message.value = chatMessageController.text.toString();

      final chatDataRef = FirebaseDatabase.instance.ref().child('Chat/$senderId/All/$receiverId/Messages');
      var currentTime = DateTime.now();
      String id = DateTime.now().microsecondsSinceEpoch.toString();
     chatDataRef.child(id).set({
        'id': id,
        'senderId': senderUserId.value.toString(),
        'receiverId': receiverUserId.value.toString(),
        'receiverName': receiverUserName.value.toString(),
        'senderName': "",
        'message':  message.value.toString(),
        'sendtime': currentTime.toString(),
        'image' : ''
      }).then((value) {
        chatMessageController.text = "";
       // Utils().toastMessage("Comment Added Successfully!");
        isLoading.value = false;
        print("Comment"+ "Comment Addedd");
      }).onError((error, stackTrace) {
        isLoading.value = false;
        print("Post"+ "Error" + error.toString());
      });

    }
  }

  void getChatMessage() async{
    blogDatabase = FirebaseDatabase.instance.ref();

    var userId= senderUserId.value;
    var senderId = receiverUserId.value;

    print("Data$userId $senderId");

    Query query = blogDatabase.child('Chat/$userId/All/$senderId/Messages');
    DataSnapshot event = await query.get();

    isLoading.value = true;
    if(event.value != null){
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        var id = value['id'].toString();
        var image = value['image'].toString();
        var message = value['message'].toString();
        var receiverId = value['receiverId'].toString();
        var receiverName = value['receiverName'].toString();
        var senderId = value['senderId'].toString();
        var senderName = value['senderName'].toString();
        var sendTime = value['sendtime'].toString();

        var isSend = false;
        if(senderId == this.userId.value){
          isSend = true;
        }

        SetChatModel setChatModel = SetChatModel(id,image,message,receiverId,receiverName,senderId,senderName,sendTime,isSend);
        listChat.add(setChatModel);
        print("Data"+ "Has Data" +message);
      });
      if(values !=null){
        isLoading.value = false;
        print("Data"+ "Has Data");
      }else{

        isLoading.value = false;
        print("Data"+ "No Data");
      }
    }else{
      isLoading.value = false;
      print("Data"+ "No Data");
    }
  }
}