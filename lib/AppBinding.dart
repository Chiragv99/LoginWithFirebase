import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppBinding extends Bindings{

  @override
  void dependencies() async{
    await GetStorage.init("CleanMove");
  }
}