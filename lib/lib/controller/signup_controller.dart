import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/controller/phone_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  String registerNumber = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool passwordVisible = false.obs;
  final name = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    registerNumber = Get.arguments;
    print(registerNumber);
    passwordVisible = true.obs;
  }

  Future<void> fireStore() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    FirebaseFirestore.instance.collection('user').where('number', isEqualTo: registerNumber).get().then((value) async {
      if (value.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('user').add({
          'name': name.text,
          'email': email.text,
          'number': number.text,
          'password': password.text,
          'Id_usuario': uid
        });
      } else {
        Get.snackbar('please check', 'your number is wrong or added',snackPosition: SnackPosition.BOTTOM);
      }
    });
  }



  void navigateToLogin(String number) {
    Get.toNamed("/login",arguments: number);
  }
}
