import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/otpcontroller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Center(
                child: Text(
              'OTP',
              style: TextStyle(color: CupertinoColors.white),
            ))),
        body: Center(
          child: Column(
              children: [
                TextFormField(
                  controller: controller.verificationCodeController,
                  decoration: const InputDecoration(
                      labelText: 'OTP', prefixIcon: Icon(Icons.verified)),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            CupertinoColors.systemIndigo),
                        fixedSize: MaterialStatePropertyAll(
                            Size.fromWidth(double.maxFinite))),
                    onPressed: () async {
                      controller.signUp();
                    },
                    child: const Text(
                      'Sign-Up',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
        ));
  }
}
