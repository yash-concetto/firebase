import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController{
  final number = TextEditingController();

  Future<void> getOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.toNamed("/otp",arguments: [verificationId,number.text]);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // void navigateToOtp(String verificationId,String number) {
  // }
}
