import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red.shade100,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

extension NumExtension on num {
  SizedBox get hSpace => SizedBox(height: toDouble().sp);
  SizedBox get wSpace => SizedBox(width: toDouble().sp);
}