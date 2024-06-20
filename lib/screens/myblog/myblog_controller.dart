import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/models/setMyBlogModel.dart';

import '../../routes/app_routes.dart';
import '../../uttils/appConstant.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';


class MyBlogController extends GetxController{

  // Database Refrences
  late DatabaseReference blogDatabase ;

  // For Store Data
  GetStorage getStorage;

  MyBlogController({required this.getStorage});

  RxString userId = RxString("");

  RxBool isLoading = RxBool(false);

  // For Set Blog Data
  RxList<SetMyBlogModel> listMyBlog = RxList([]);
  late SetMyBlogModel setMyBlogModel ;

  @override
  void onInit() {
    super.onInit();
    isLoading = RxBool(false);
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    blogDatabase = FirebaseDatabase.instance.ref('Blog');
  }

  void editBlog(SetMyBlogModel setMyBlogModel) async{
    Get.toNamed(Routes.postScreen,arguments:  {"isData": true,"title": setMyBlogModel.title,"desc": setMyBlogModel.desc,"url": ""});
  }

  void deleteBlog(String blogId) async {
    blogDatabase
        .child(blogId)
        .remove()
        .then((value) {
      Utils().toastMessage("Record Deleted Successfully");
      getMyBlog();
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      print("Record Error");
    });
  }

  void getMyBlog() async{

    isLoading.value = true;
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    blogDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);


    Query query = blogDatabase.orderByChild("userId").equalTo(userId.value);
    DataSnapshot event = await query.get();


    if(event.value != null){
      listMyBlog.value.clear();
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        var blogTime = value['time'].toString();
        var id = value['id'].toString();
        var title = value['title'].toString();
        var desc = value['desc'].toString();
        var image = value['image'].toString();
        var username = value['name'].toString();

        SetMyBlogModel setMyBlogModel = SetMyBlogModel(userId.value, blogTime, id, title, desc, image,blogTime,"");
        listMyBlog.value.add(setMyBlogModel);
      });
      if(values !=null){
        isLoading.value = false;
        print("Data"+ "Has Data");
      }else{
        listMyBlog.value.clear();
        isLoading.value = false;
        print("Data"+ "No Data");
      }
    }else{
      listMyBlog.value.clear();
      isLoading.value = false;
      print("Data"+ "No Data");
    }
  }
}