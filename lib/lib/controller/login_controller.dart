import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/controller/phone_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class   LoginController extends GetxController {

  FirebaseAuth auth = FirebaseAuth.instance;
  String getRegisterNumber = '';

  RxBool passwordVisible = false.obs;
  final number = TextEditingController();
  final password = TextEditingController();
  // GlobalKey<FormState> LoginFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    getRegisterNumber = Get.arguments;
    print(getRegisterNumber);
    passwordVisible = true.obs;
  }

  Future<void> check() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    // var query = FirebaseFirestore.instance.collection('user');
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('user');
        query = query.where('number', isEqualTo: number.text);
        query = query.where('password', isEqualTo: password.text);
            query.get().then((value) async {
      if (value.docs.isNotEmpty) {
        Get.toNamed('/chat',arguments: getRegisterNumber);
      } else {
        Get.snackbar('please check', 'Invalid number or password',snackPosition: SnackPosition.BOTTOM);
      }
    });
  }



  void navigateToSign() {
    Get.toNamed("/phone");
  }
}
