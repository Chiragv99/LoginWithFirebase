import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/home/home_controller.dart';
import 'package:focus_detector/focus_detector.dart';

class HomeScreen extends GetView<HomeController>{

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
       onFocusGained: (){
         controller.readData();
       },
      onFocusLost: (){},
      child:  Scaffold(
        appBar: AppBar(
          title: Text("Blog"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FirebaseAnimatedList(
              query: controller.blogDatabase,defaultChild: Text("Loading.."),
              itemBuilder: (context,snapshot,animation,index){
                final id = snapshot.child('id').value.toString();
                final image = snapshot.child('image').value.toString();
                final time = snapshot.child("time").value.toString();
                final title = snapshot.child("title").value.toString();
                final description =
                snapshot.child("description").value.toString();
                final email = snapshot.child("email").value.toString();
                final uid = snapshot.child('uid').value.toString();
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: 
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.child('name').value.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.child('title').value.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.child('desc').value.toString()),
                        SizedBox(
                          width: Get.width,
                          height: Get.height /6,
                          child:   Image.network(snapshot.child('image').value.toString(),fit: BoxFit.fitWidth,),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
        ),
      ),
    );
  }
}