import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
RxBool iaActive = true.obs;

  @override
  void onInit() {
   // navigateToNext();
    super.onInit();
  }

  Future<void> navigateToNext() async {
    // Get.toNamed('/phone');
    if(FirebaseAuth.instance.currentUser != null){
      await Get.toNamed("/chat");
      if(await checkConnection()){
        iaActive.value == true;
        // debounce(listener, (callback) => null);
        debugPrint("we arr back from chat");
      }
    }else{
        // iaActive.value == true;
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
