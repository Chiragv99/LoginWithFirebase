import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/uttils/uttils.dart';

import '../../../models/setProfileData.dart';
import '../../../routes/app_routes.dart';
import '../../../uttils/appConstant.dart';
import '../../../uttils/preferenceUtils.dart';

class OtherProfileController extends GetxController{

  // For User Data
  RxString receiverUserId = RxString("");
  RxString senderUserId = RxString("");

  RxString userName = RxString("");
  RxString userProfileImage = RxString("");

  RxInt  totalMyPost = RxInt(0);


  RxBool isImage = RxBool(false);
  File? image;

  RxList<SetProfileData> listProfileData = RxList([
    SetProfileData("icon_privacy.png", "Blog's".tr,  null)
  ]);

  late SetProfileData setProfileData;


  // For Store Data
  GetStorage getStorage;


  OtherProfileController({required this.getStorage});

  // Database Refrences
  late DatabaseReference sendFollowRequestDatabase ;

  RxBool isLoading = RxBool(false);

  RxInt requestStatus = RxInt(0);
  RxString buttonText = RxString("Follow");

  @override
  void onInit() {
    super.onInit();
    receiverUserId.value = Get.arguments["userId"];
    senderUserId.value = PreferenceUtils.getString(AppConstant.userId);
    userName.value = PreferenceUtils.getString(AppConstant.username,"");

    userName.value = Get.arguments["name"];
    userProfileImage.value = Get.arguments["profileImage"];

    sendFollowRequestDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserFollowData);

    checkFollowStatus();
  }

  void sendFollowRequest() {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final sendFollowRequest = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserFollowData);
    sendFollowRequest.child(id).set({
      'id': id,
      'senderId': senderUserId.value,
      'receiverId': receiverUserId.value,
      'time': id,
      'profileImageUrl': '',
      'status': 0
    }).then((value) {
      print("Post"+ "User Addedd");
      buttonText.value = "Requested";
    }).onError((error, stackTrace) {
      print("Post"+ "Error");
    });
  }

  void redirectToChatScreen(){
   print("Chat"+"Chat");
//   Get.offAndToNamed(Routes.chatPage);
   Get.toNamed(Routes.chatPage,arguments: {"receiverName": userName.value,"receiverId":  receiverUserId.value,'senderId': senderUserId.value});
  }
  void requestSendAlready(){
    Utils().toastMessage("Request has been already sent!");
  }

  void checkFollowStatus() async{
    isLoading.value = true;

    Query query = sendFollowRequestDatabase.orderByChild("senderId").equalTo(senderUserId.value);
    DataSnapshot event = await query.get();

    if(event.value != null){
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        var status = value["status"];
       // print("Status"+ status);
        if(status == 0){
          requestStatus.value = 0 ;
          buttonText.value = "Requested";
        }
        if(status == 1){
          requestStatus.value = 1 ;
          buttonText.value = "Following";
        }
        if(status == 2){
          requestStatus.value = 2 ;
          buttonText.value = "Chat";
        }
        print("Data"+ "Has Data" + status.toString());
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

