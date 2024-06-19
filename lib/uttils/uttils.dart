import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginwithfirebase/uttils/theme_color.dart';

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

// Box Decoration for Setting
BoxDecoration backgroundDecoration(){
  return  BoxDecoration(
    border:
    Border.all(color: ThemeColor.disableColor, width: 0.1),
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: Colors.white,
        blurRadius: 3.0,
        offset: Offset(0.0, 3.0),
      ),
    ],
  );
}