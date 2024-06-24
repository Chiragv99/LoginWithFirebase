import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/setProfileData.dart';
import '../../uttils/appConstant.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';
import '../../widget/firebase_api.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{

  // For Show Loading
  RxBool isLoading = RxBool(false);


  // For Store Data
  GetStorage getStorage;

  ProfileController({required this.getStorage});

  RxList<SetProfileData> listProfileData = RxList([
    SetProfileData("icon_privacy.png", "My Blog".tr,  null,),
    SetProfileData("icon_privacy.png", "Follow Request".tr,  null,)
  ]);

  File? image;
  final picker = ImagePicker();

  RxBool isImage = RxBool(false);


  UploadTask? task;
  File? file;


  // For User Data
  RxString userId = RxString("");
  RxString userName = RxString("");
  RxInt  totalMyPost = RxInt(0);
  RxInt  totalFollowRequest = RxInt(0);

  // Database Refrences
  late DatabaseReference blogDatabase ;

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
    isImage.value = false;
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    userName.value = PreferenceUtils.getString(AppConstant.username,"");
    getTotalPostCount();
    getTotalFollowRequestCount();

    if(Get.arguments == true){
      var isArgument = true;
      print("Argument"+ isArgument.toString());
    }
  }

  // Upload Image from Gallery
  void uploadImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    isImage.value = true;

    final fileName = basename(image!.path);
    final destination = 'files/$fileName';
    print("File$destination");

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(image!);

    task = FirebaseApi.uploadTask(destination, image!);

    final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserData);

    uploadTask.then((res) async{
      var imageUrl = await ref.getDownloadURL();
      blogDataRef.child(userId.value).update({
        'profileImageUrl': imageUrl,
      }).then((value) {
        isLoading.value = false;
        Utils().toastMessage("Post Upload Successfully!");
        updateUserProfileInBlog(imageUrl);
        print("Post"+ "Post Addedd");
      }).onError((error, stackTrace) {
        isLoading.value = false;
        print("Post"+ "Error");
      });
    });

  }

  // Upload Image from Camera
  void uploadImageFromCamera() async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    isImage.value = true;
  }

  updateUserProfileInBlog(String imageUrl) async{
    DatabaseReference  userDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

    Query query = userDatabase.orderByChild("userId").equalTo(userId.value);
    DataSnapshot event = await query.get();

    if(event.value != null){
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      if(values !=null){
        values.forEach((key, value) {

          updateProfileImageInBlog(imageUrl, value['id'].toString());
        });
      }else{
        isLoading.value = false;
        print("Data"+ "No Data");
      }
    }else{
      isLoading.value = false;
      print("Data"+ "No Data");
    }
  }

  void updateProfileImageInBlog(String imageUrl, String userId) async{

    final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);
    blogDataRef.child(userId).update({
      'profileImage': imageUrl
    }).then((value) {
      print("ProfileImage"+ 'Updated');
    }).onError((error, stackTrace) {
      print("ProfileImage"+ 'Error');
    });
  }

  void getTotalPostCount() async{
    blogDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

    Query query = blogDatabase.orderByChild("userId").equalTo(userId.value);
    DataSnapshot event = await query.get();

    if(event.value != null){
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      var list = values.values.toList();
      if(list !=null){
        totalMyPost.value = list.length;
      }
      print("""TotalPost"""+ list.length.toString());
    }
  }

  void getTotalFollowRequestCount() async{

   var sendFollowRequestDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserFollowData);

    Query query = sendFollowRequestDatabase.orderByChild("senderId").equalTo(userId.value);
    DataSnapshot event = await query.get();

   if(event.value != null){
     Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
     var list = values.values.toList();
     if(list !=null){
       totalFollowRequest.value = list.length;
     }
     print("""TotalReceive"""+ list.length.toString());
   }
  }
}