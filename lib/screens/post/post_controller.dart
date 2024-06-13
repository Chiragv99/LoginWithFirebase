import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:loginwithfirebase/widget/firebase_api.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';
import 'package:path/path.dart';

class PostController extends GetxController{

  // For Show Loading
  RxBool isLoading = RxBool(false);

  // Text Input Controller
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController blogUrl = TextEditingController();

  // Form key for InputText
  final formKey = GlobalKey<FormState>();

  // Database Refrences
  late DatabaseReference blogDatabase ;

  XFile? imageData;


  File? image;
  final picker = ImagePicker();


  UploadTask? task;
  File? file;
  RxString userId = RxString("");
  RxString userName = RxString("");
  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    userName.value = PreferenceUtils.getString(AppConstant.username);
    print("UserId"+ userId.value.toString());
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
    final username = PreferenceUtils.getString(AppConstant.username,"");

    print("Username"+ username);

    var title = titleController.text.toString().trim();
    var desc = descController.text.toString().trim();
    if(title.isEmpty){
      Utils().toastMessage("Please Enter Title");
    }
    else if(desc.isEmpty){
      Utils().toastMessage("Please Enter Desc");
    }
    else{
      isLoading.value = true;
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);


      final fileName = basename(image!.path);
      final destination = 'files/$fileName';
      print("File$destination");

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image1${DateTime.now()}");
      UploadTask uploadTask = ref.putFile(image!);

      task = FirebaseApi.uploadTask(destination, image!);

      print("UserId"+ uid.toString());

      uploadTask.then((res) async{
        var imageUrl = await ref.getDownloadURL();
        blogDataRef.child(id).set({
          'id': id,
          'userId': userId.value.toString(),
          'time':id,
          'title': titleController.text.toString().trim(),
          'desc': descController.text.toString().trim(),
          'url': blogUrl.text.toString().trim(),
          'image': imageUrl,
          'name': username,
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
  }

  void setDataBlank() {

  }

}