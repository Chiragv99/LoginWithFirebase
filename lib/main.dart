import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/uttils/appConstant.dart';
import 'AppBinding.dart';
import 'defaultFirebaseConfig.dart';
import 'routes/app_routes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  await Firebase.initializeApp(options : DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      initialRoute: Routes.splashScreen,
      onInit: (){
        ScreenUtil.init(context);
        Get.put(GetStorage(AppConstant.storageName));
      },
      initialBinding: AppBinding(),
    );
  }
}

