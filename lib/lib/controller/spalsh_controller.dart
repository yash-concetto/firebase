import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/controller/login_controller.dart';
import 'package:firebase/lib/controller/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  // final controller = Get.put(LoginController());
RxBool iaActive = true.obs;

  @override
  void onInit() {
   // navigateToNext();
    super.onInit();
  }

  Future<void> navigateToNext() async {
    if(FirebaseAuth.instance.currentUser != null){
      Get.toNamed("/chat");
    }else{
        Get.toNamed("/login");
    }
  }

  Future<void> fireStore() async {
    // final User? user = auth.currentUser;
    // final userUid = user!.uid;
    // if (message.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance.collection('chat-data').add({
        'isActive': iaActive.value,
        // 'message': message.text,
        // 'time': DateTime.now(),
        // 'Id_userUid': userUid
      });
    }


  Future<bool> checkConnection() async {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // messageModel.checkConnection = true;
      // return checkNetwork;
      print('connected');
    }
    return true;
    // checkNetwork.isTrue.obs;
  }
}
