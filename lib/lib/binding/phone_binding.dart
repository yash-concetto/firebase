import 'package:firebase/lib/controller/phone_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class PhoneBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<PhoneController>(PhoneController());
  }
}