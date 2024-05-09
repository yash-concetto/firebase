import 'package:firebase/lib/controller/chat_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController());
  }
}