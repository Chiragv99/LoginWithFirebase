import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
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
          title: const Text("Blog"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
            child: FirebaseAnimatedList(
              query: controller.blogDatabase,defaultChild: setLoading(),
              itemBuilder: (context,snapshot,animation,index){
                final id = snapshot.child('id').value.toString();
                final image = snapshot.child('image').value.toString();
                final time = snapshot.child("time").value.toString();
                final title = snapshot.child("title").value.toString();
                final description =
                snapshot.child("description").value.toString();
                final email = snapshot.child("email").value.toString();
                final uid = snapshot.child('uid').value.toString();
                return
                  Padding(padding: const EdgeInsets.only(top: 10,left: 5,right: 5),child:
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.child('name').value.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
                            Text(snapshot.child('time').value.toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
                          ],
                        ),
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
                ));
              },
            )
        ),
      ),
    );
  }

 Widget setLoading(){
    return Container(
      width: Get.width,
      height: Get.height,
      child:
      const Center(
        child:Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text("Please Wait..")
          ],
        ) ,
      ),
    );
  }

}