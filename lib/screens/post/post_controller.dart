import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:loginwithfirebase/widget/firebase_api.dart';
import '../../models/setMyBlogModel.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';
import 'package:path/path.dart';

class PostController extends GetxController{

  // For Show Loading
  RxBool isLoading = RxBool(false);

  // Text Input Controller
   TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController blogUrl = TextEditingController();

  // Form key for InputText
  final formKey = GlobalKey<FormState>();

  // Database Refrences
  late DatabaseReference blogDatabase ;


  File? image;
  final picker = ImagePicker();


  UploadTask? task;
  File? file;
  RxString userId = RxString("");
  RxString userName = RxString("");
  RxString userProfileImage = RxString("");
  RxString buttonText = RxString("Upload Blog");

  RxBool  isData = RxBool(false);

  SetMyBlogModel? setMyBlogModel;

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    userName.value = PreferenceUtils.getString(AppConstant.username);
    isData.value = false;
    isData.value = Get.arguments?['isData'] ?? false;
    if(isData.value == true){
      titleController.text = Get.arguments['title'];
      print("IsData"+  Get.arguments['title']);
    }
    getUserProfileImage();
   // print("IsData"+ isData.value.toString());
  }

  // Upload Image from Gallery
  void uploadImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
  }

  // Upload Image from Camera
  void uploadImageFromCamera() async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
  }

  void addBlog() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    print("image"+ image.toString());

    var title = titleController.text.toString().trim();
    var desc = descController.text.toString().trim();
    if(title.isEmpty){
      Utils().toastMessage("Please Enter Title");
    }
    else if(desc.isEmpty){
      Utils().toastMessage("Please Enter Desc");
    }
    else if(image == null){
      Utils().toastMessage("Please Select Images");
    }
    else{

      print("UserId"+ uid.toString());

      if(setMyBlogModel != null){
        updateData(setMyBlogModel!.blogId);
      }else{
        addBlogData();
      }
    }
  }

  void setDataBlank() {
    titleController.clear();
    descController.clear();
    blogUrl.clear();
    image = null;
  }

  void updateData(String blogId) {
    final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

    if(image.isBlank == false){
      final fileName = basename(image!.path);
      final destination = 'files/$fileName';
      print("File$destination");
    }

    blogDataRef.child(blogId).update({
      'title': titleController.text,
      'desc': descController.text,
    }).then((value) {
      print("Title${titleController.text}");
      Utils().toastMessage("Post Update");
      Get.back();
    }).onError((error, stackTrace) {
      Utils()
          .toastMessage(error.toString());
    });
  }

  void addBlogData() {
    isLoading.value = true;
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

    final username = PreferenceUtils.getString(AppConstant.username,"");

    final fileName = basename(image!.path);
    final destination = 'files/$fileName';
    print("File$destination");

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(image!);

    task = FirebaseApi.uploadTask(destination, image!);


    var blogComment = [];
    var blogLike  = [];

    var currentTime = DateTime.now();
    uploadTask.then((res) async{
      var imageUrl = await ref.getDownloadURL();
      blogDataRef.child(id).set({
        'id': id,
        'userId': userId.value.toString(),
        'time':currentTime.toString(),
        'title': titleController.text.toString().trim(),
        'desc': descController.text.toString().trim(),
        'url': blogUrl.text.toString().trim(),
        'image': imageUrl,
        'profileImage': userProfileImage.value.toString(),
        'name': username,
        'comment': blogComment,
        'like': blogLike,
      }).then((value) {
        isLoading.value = false;
        Utils().toastMessage("Post Upload Successfully!");
        setDataBlank();
        print("Post"+ "Post Addedd");
      }).onError((error, stackTrace) {
        isLoading.value = false;
        print("Post"+ "Error");
      });
    });

  }

  Future getUserProfileImage() async{
    DatabaseReference  userDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserData);

    Query query = userDatabase.orderByChild("userId").equalTo(userId.value);
    DataSnapshot event = await query.get();

    if(event.value != null){
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      if(values !=null){
        values.forEach((key, value) {
          userProfileImage.value = value['profileImageUrl'].toString();
          print("ProfileImage"+ userProfileImage.toString());
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
}