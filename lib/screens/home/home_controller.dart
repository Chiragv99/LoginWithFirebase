import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'package:intl/intl.dart';

import '../../models/setMyBlogModel.dart';
import '../../routes/app_routes.dart';
import '../../uttils/preferenceUtils.dart';
import '../../uttils/uttils.dart';

class HomeController extends GetxController{

  RxBool isLoading = RxBool(false);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Database Refrences
  late DatabaseReference blogDatabase ;

  int selectedIndex = 0;
  RxString filterTag = "".obs;



  // For Set Blog Data
  RxList<SetMyBlogModel> listAllBlog = RxList([]);
  late SetMyBlogModel setMyBlogModel ;

  RxString userId = RxString("");

  @override
  void onInit() async{
    super.onInit();
    userId.value = PreferenceUtils.getString(AppConstant.userId);
    isLoading = RxBool(false);
    blogDatabase = FirebaseDatabase.instance.ref('Blog');
    getAllUserPost();
  }

  deleteData() async{
    FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName).remove();
  }

   onItemTapped(int index) {
    selectedIndex = index;
  }

  redirectToBlogDetail(SetMyBlogModel setMyBlogModel){
    Get.toNamed(Routes.blogDetail,arguments:  setMyBlogModel);
  }

  redirectToProfile(SetMyBlogModel setMyBlogModel){
    Get.toNamed(Routes.otherProfile,arguments: {"name": setMyBlogModel.userName,"userId": setMyBlogModel.userId,"profileImage": setMyBlogModel.profileImage});
  }

  getAllUserPost() async{
    isLoading.value = true;
    blogDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageName);

    Query query = blogDatabase;
    DataSnapshot event = await query.get();

    if(event.value != null){
      listAllBlog.value.clear();
      Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
      values.forEach((key, value) async {

        var userId = value['userId'].toString();
        var blogTime = value['time'].toString();
        var id = value['id'].toString();
        var title = value['title'].toString();
        var desc = value['desc'].toString();
        var image = value['image'].toString();
        var username = value['name'].toString();
        var profileImage = value['profileImage'].toString();
        var totalLike = [] ;
        var totalComment = [] ;
        if(value['like'] != null){
          totalLike = value['like'];
        }
        if(value['comment'] != null){
          totalComment = value['comment'];
        }

        /*final blogDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageBlogComment);
        Query query = blogDataRef.orderByChild("blogId").equalTo(id);
        DataSnapshot event = await query.get();

        var totalCommentLength = 0;
        if(event.value != null){
          Map<dynamic, dynamic> values = event.value as Map<dynamic, dynamic>;
          if(values !=null){
            totalCommentLength = values.length;
          }else{
            print("Data"+ "No Data");
          }
        }else{
          print("Data"+ "No Data");
        }
*/
        DateTime dateTime = DateTime.parse(blogTime);
        var parseDate = "";
         parseDate = getFilterDateTime(dateTime,parseDate);

         var isLiked = false;
         if(totalLike.isNotEmpty && totalLike.contains(this.userId.value)){
           isLiked = true;
         }

        SetMyBlogModel setMyBlogModel = SetMyBlogModel(userId, parseDate, id, title, desc, image,username,profileImage,totalLike.length,0,totalLike,totalComment,isLiked);
        listAllBlog.value.add(setMyBlogModel);
      });

      if(values !=null){
        isLoading.value = false;
        print("Data"+ "Has Data");
      }else{
        listAllBlog.value.clear();
        isLoading.value = false;
        print("Data"+ "No Data");
      }
    }else{
   //   listAllBlog.value.clear();
      isLoading.value = false;
      print("Data"+ "No Data");
    }
  }

  saveBlog(SetMyBlogModel setMyBlogModel) async{

    String id = DateTime.now().microsecondsSinceEpoch.toString();
    var blogDatabase = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserSavedBlog);

    blogDatabase.child(id).set({
      'id': id,
      'userId': userId.value,
      'time':setMyBlogModel.blogTime,
      'title': setMyBlogModel.title,
      'desc': setMyBlogModel.desc,
      'url': "",
      'image': setMyBlogModel.image,
      'profileImage': setMyBlogModel.profileImage,
      'name': "",
      'comment': selectedIndex,
      'like': setMyBlogModel.isLiked,
    }).then((value) {
      isLoading.value = false;
      Utils().toastMessage("Post Upload Successfully!");
      print("Post"+ "Post Addedd");
    }).onError((error, stackTrace) {
      isLoading.value = false;
      print("Post"+ "Error");
    });
  }
}

DateTime changeDateFormate(String strDate) {
  DateTime parseDate = DateFormat("yyyy-MM-dd").parse(strDate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('dd-MM-yyyy');
  var outputDate = outputFormat.format(inputDate);
  return DateFormat("dd-MM-yyyy").parse(outputDate).toLocal();
}

void _sendMessage() async {

}
