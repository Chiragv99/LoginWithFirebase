import 'package:get/get.dart';
import 'package:loginwithfirebase/common/tabbar_binding.dart';
import 'package:loginwithfirebase/common/tabbar_screen.dart';
import 'package:loginwithfirebase/screens/home/home_binding.dart';
import 'package:loginwithfirebase/screens/home/home_screen.dart';
import 'package:loginwithfirebase/screens/login/login_binding.dart';
import 'package:loginwithfirebase/screens/login/login_screen.dart';
import 'package:loginwithfirebase/screens/post/post_binding.dart';
import 'package:loginwithfirebase/screens/post/post_screen.dart';
import 'package:loginwithfirebase/screens/registration/registration_binding.dart';
import 'package:loginwithfirebase/screens/registration/registration_screen.dart';

import '../screens/splash/splash_binding.dart';
import '../screens/splash/splash_screen.dart';

class Routes{
  static String splashScreen = "/splash" ;
  static String loginScreen = "/loginScreen";
  static String signupScreen = "/registrationScreen";
  static String homeScreen = "/homeScreen";
  static String postScreen = "/postScreen";
  static String tabBarScreen = "/tabBarScreen";

  static final routes = [
    GetPage(
        name: '/splash',
        page: () => SlashPage(),
        binding: SplashBinding()
    ),
    GetPage(
        name: loginScreen,
        page: () => LoginScreen(),
        binding: LoginBinding()
    ),
    GetPage(
        name: signupScreen,
        page: () => RegistrationScreen(),
        binding: RegistrationBinding()
    ),
    GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
        binding: HomeBinding()
    ),
    GetPage(
        name: postScreen,
        page: () => PostScreen(),
        binding: PostBinding()
    ),
    GetPage(
        name: tabBarScreen,
        page: () => const TabBarScreen(),
        binding: TabBarBinding()
    ),
  ];
}