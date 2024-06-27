import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginwithfirebase/screens/test/test_controller.dart';

class TestScreen extends GetView<TestController>{
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Data"),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Data"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Data"),
                )
              ],
            )
           )
    );
  }
}