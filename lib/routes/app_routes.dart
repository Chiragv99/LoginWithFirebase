import 'package:get/get.dart';
import 'package:loginwithfirebase/common/tabbar_binding.dart';
import 'package:loginwithfirebase/common/tabbar_screen.dart';
import 'package:loginwithfirebase/screens/home/home_binding.dart';
import 'package:loginwithfirebase/screens/home/home_screen.dart';
import 'package:loginwithfirebase/screens/login/login_binding.dart';
import 'package:loginwithfirebase/screens/login/login_screen.dart';
import 'package:loginwithfirebase/screens/myblog/blogDetail/blogdetail_binding.dart';
import 'package:loginwithfirebase/screens/myblog/blogDetail/blogdetail_screen.dart';
import 'package:loginwithfirebase/screens/myblog/myblog_binding.dart';
import 'package:loginwithfirebase/screens/myblog/myblog_screen.dart';
import 'package:loginwithfirebase/screens/post/post_binding.dart';
import 'package:loginwithfirebase/screens/post/post_screen.dart';
import 'package:loginwithfirebase/screens/profile/profile_screen.dart';
import 'package:loginwithfirebase/screens/registration/registration_binding.dart';
import 'package:loginwithfirebase/screens/registration/registration_screen.dart';
import 'package:loginwithfirebase/screens/setting/setting_binding.dart';
import 'package:loginwithfirebase/screens/setting/setting_screen.dart';

import '../screens/profile/profile_binding.dart';
import '../screens/splash/splash_binding.dart';
import '../screens/splash/splash_screen.dart';

class Routes{
  static String splashScreen = "/splash" ;
  static String loginScreen = "/loginScreen";
  static String signupScreen = "/registrationScreen";
  static String homeScreen = "/homeScreen";
  static String postScreen = "/postScreen";
  static String tabBarScreen = "/tabBarScreen";
  static String settingScreen = "/settingScreen";
  static String profileScreen = "/profileScreen";
  static String myBlog = "/myblogscreen";
  static String blogDetail = "/blogDetail";

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
    GetPage(
        name: settingScreen,
        page: () =>  SettingScreen(),
        binding: SettingBindings()
    ),
    GetPage(
        name: profileScreen,
        page: () =>  ProfileScreen(),
        binding: ProfileBindings()
    ),
    GetPage(
        name: myBlog,
        page: () =>  MyBlogScreen(),
        binding: MyblogBinding()
    ),
    GetPage(
        name: blogDetail,
        page: () =>  BlogDetailScreen(),
        binding: BlogDetailBindings()
    ),
  ];
}