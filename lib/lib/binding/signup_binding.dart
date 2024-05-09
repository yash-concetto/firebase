import 'package:firebase/lib/controller/signup_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class SignupBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController());
  }
}