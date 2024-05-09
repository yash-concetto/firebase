import 'package:firebase/lib/controller/otpcontroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class OtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<OtpController>(OtpController());
  }
}