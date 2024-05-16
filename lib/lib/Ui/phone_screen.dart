import 'package:firebase/lib/controller/phone_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneScreen extends GetView<PhoneController> {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneController());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Center(
                child: Text(
              'Phone',
              style: TextStyle(color: CupertinoColors.white),
            ))),
        body: Center(
          child: Column(
            children: [
              TextFormField(
                controller: controller.number,
                decoration: const InputDecoration(labelText: 'Phone-number',prefixIcon: Icon(Icons.phone)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(CupertinoColors.systemIndigo),
                      fixedSize: MaterialStatePropertyAll(Size.fromWidth(double.maxFinite))),
                  onPressed: () async{
                   controller.getOtp();
                  },
                  child: const Text('Get OTP',style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
    );
  }
}
