
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppConstant {
 static const homeIcon = 'assets/vectors/home.svg';
 static  String assestPath = 'assets/images/';
 static  String assestPathIcon = 'assets/icons/';
 static double inputLabelSize = 12.0;
 static double buttonSize = 5.0.sp ;

 //  For Get Device Width and Height
 static double deviceWidth = Get.width;
 static double deviceHeight = Get.width;

 // Font Family
 static const String labelFrontRegular = 'Poppins-Regular' ;
 static const String labelFrontLight = 'Poppins-Light' ;
 static const String labelFrontBold = 'Poppins-Bold' ;
 static const String labelFrontLightItalic = 'Poppins-LightItalic.ttf' ;

 // For Language Translation
 static const String languageCode = "language_code";
 static const String countryCode = "country_code";
 static const String authToken = "authToken";
 static const String keepMeLogin = "keepMeLogin";
 static const String userRole = "userRole";

 
 static const String rememberMe = "rememberMe";
 static const String username = "userName";
 static const String password = "password";
 static const String userId = "userId";
 static const String profileName = "profileName";
 static const String email = "email";

 static const String storageName = "CleanMove";
 static const int roleIdPassenger =  7;
 static const int roleIdDriver =   6;

 static const Locale englishUS = Locale("en", "US");
 static const Locale spanishES = Locale("es", "ES");
 static const Locale portuguesePT = Locale("pt", "PT");

 static const String SosCall = "Call";
 static const String SosEmail = "Email";

 static  String noInternetMessage = "No Internet! Please Check Your Internet And Try Again".tr;

 static  String otpSentMessage = "OTP sent successfully to your number, please check your register number".tr;

 static  String authError = "Authorization Error!".tr;


// static  String imagePathBaseUrl = "http://192.168.1.8:2018/";

 // Image Constant
static String tempUserIcon = "temp_user_icon.png";

static int polylineWidth = 5 ;

// Route Status
static var updateRouteStatusReadyToGo = 1 ;
 static var updateRouteStatusStart = 2 ;
 static var updateRouteStatusCompletedTrip = 3 ;



 static const background = 'assets/images/background.png';
 static const backgroundDark = 'assets/images/background_dark.png';
 static const avatar = 'assets/images/avatar.png';
 static const calendar = 'assets/images/calendar.png';
 static const lotus = 'assets/images/lotus.png';
 static const matches = 'assets/images/matches.png';
 static const favourites = 'assets/images/favourites.png';

 static const lambMeat = 'assets/images/lamb_meat.png';
 static const bellPepper = 'assets/images/bell_pepper.png';
 static const cabbage = 'assets/images/cabbage.png';
 static const carrot = 'assets/images/carrot.png';
 static const cauliflower = 'assets/images/cauliflower.png';
 static const ginger = 'assets/images/ginger.png';
 static const pumpkin = 'assets/images/pumpkin.png';
 static const spinach = 'assets/images/spinach.png';
 static const tomatoes = 'assets/images/tomatoes.png';


 static const backArrowIcon = 'assets/vectors/back_arrow.svg';
 static const addIcon = 'assets/vectors/add.svg';
 static const removeIcon = 'assets/vectors/remove.svg';
 static const searchIcon = 'assets/vectors/search.svg';
 static const themeIcon = 'assets/vectors/theme.svg';
 static const basketIcon = 'assets/vectors/basket.svg';
 static const cornIcon = 'assets/vectors/corn.svg';
 static const fireIcon = 'assets/vectors/fire.svg';
 static const emojiIcon = 'assets/vectors/emoji.svg';
 static const container = 'assets/vectors/container.svg';


 static const firebaseStorageName = 'Blog';
 static const firebaseStorageUserData = 'User';
 static const firebaseStorageBlogComment = 'Comment';
 static const firebaseStorageUserFollowData = 'Follow';
 static const firebaseStorageUserSavedBlog = 'Saved';
 static const firebaseStorageUserChat = 'Chat';
}