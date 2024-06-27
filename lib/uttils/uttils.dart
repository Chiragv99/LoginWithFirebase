import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loginwithfirebase/uttils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

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

void isValidURL (String url){
  if(url == null || url == ""){

  }
}

getFilterDateTime(DateTime blogDate, String filterTag) {
  DateTime previousDate = changeDateFormate(DateTime.now().toString())
      .subtract(const Duration(days: 1));
  if(changeDateFormate(blogDate.toString()) == changeDateFormate(
      DateTime.now().toString())){
    filterTag = "Today";
    filterTag =  DateFormat('HH:MM a').format(
        DateTime.parse(blogDate.toString()));
  }else if(changeDateFormate(blogDate.toString()) == previousDate){
    filterTag = "YesterDay: ${DateFormat('HH:MM a').format(
        DateTime.parse(blogDate.toString()))}";
  }else {
    filterTag = DateFormat('EEEE dd MMM').format(
        DateTime.parse(blogDate.toString()));
  }
  return filterTag;
}

DateTime changeDateFormate(String strDate) {
  DateTime parseDate = DateFormat("yyyy-MM-dd").parse(strDate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('dd-MM-yyyy');
  var outputDate = outputFormat.format(inputDate);
  return DateFormat("dd-MM-yyyy").parse(outputDate).toLocal();
}

loadShimmer(double height){
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemCount: 5, // Adjust the count based on your needs
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
            height: height,
            width: 200,
            color: Colors.white,
          ),
        );
      },
    ),
  );
}