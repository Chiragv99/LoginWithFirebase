import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginwithfirebase/screens/profile/otherprofile/otherprofile_controller.dart';

import '../../../uttils/appConstant.dart';

class OtherProfileBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => OtherProfileController(getStorage:  GetStorage(AppConstant.storageName)));
  }

}