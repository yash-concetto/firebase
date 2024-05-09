import 'package:firebase/lib/controller/login_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}