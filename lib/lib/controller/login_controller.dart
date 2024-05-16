import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/controller/phone_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String registerNumber = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool passwordVisible = false.obs;
  final number = TextEditingController();
  final password = TextEditingController();
  // GlobalKey<FormState> LoginFormKey = GlobalKey<FormState>();


  @override
  void onReady() {
    if(Get.arguments != null) {
      registerNumber = Get.arguments;
      print('22${registerNumber}');
    }
    passwordVisible = true.obs;
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> check() async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('user');
        query = query.where('number', isEqualTo: number.text);
        query = query.where('password', isEqualTo: password.text);
            query.get().then((value) async {
      if (value.docs.isNotEmpty) {
        navigateToChat(registerNumber);
        // Get.toNamed('/chat',arguments: getRegisterNumber);
      } else {
        Get.snackbar('please check', 'Invalid number or password',snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  void navigateToChat(String number) {
    Get.toNamed("/chat",arguments: number);
  }

  void navigateToSign() {
    Get.toNamed("/phone");
  }
}
