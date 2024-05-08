import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  RxString verificationId = ''.obs;
  RxString number = ''.obs;
  final verificationCodeController = TextEditingController();
  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    argumentData = Get.arguments;
    print('14${argumentData[0]}');
    print('15${argumentData[1]}');
    // argumentData[0] = verificationId;
    // argumentData[1] = number;
    // print("18${verificationId.value}");
    // print('19${number.value}');
    // verificationId.value = Get.arguments;
    super.onInit();
  }

  void signUp() {
    final credential = PhoneAuthProvider.credential(
      verificationId: argumentData[0],
      smsCode: verificationCodeController.text,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      navigateToSignup(argumentData[1]);
    });
  }

  void navigateToSignup(String number) {
    Get.toNamed("/sign",arguments: number);
  }
}
