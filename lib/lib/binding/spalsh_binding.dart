import 'package:firebase/lib/controller/spalsh_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}