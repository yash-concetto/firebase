import 'package:firebase/lib/controller/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,title: const Center(child: Text('Add Data',style: TextStyle(color: CupertinoColors.white),))),
      body: Form(
        key: controller.signupFormKey,
        child: Padding(
        padding: const EdgeInsets.only(top: 60,left: 15,right: 15),
        child: SingleChildScrollView(
          child:  Obx(() => Column(
            children: [
                  TextFormField(
                    controller: controller.name,
                    decoration: const InputDecoration(labelText: 'Name',prefixIcon: Icon(Icons.perm_identity)),
                  ),
              const SizedBox(height: 30),
              // TextFormField(
              //   controller: controller.number,
              //   decoration: const InputDecoration(labelText: 'Number',prefixIcon: Icon(Icons.phone)),
              // ),
              // const SizedBox(height: 30),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(labelText: 'E-mail',prefixIcon: Icon(Icons.email)),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: controller.password,
                obscureText: controller.passwordVisible.value,
                decoration:  InputDecoration(labelText: 'Password',prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        icon: Icon(controller.passwordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed:() {
                              controller.passwordVisible.value = !(controller.passwordVisible.value);
                        }),
                   ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(CupertinoColors.systemIndigo),
                      fixedSize: MaterialStatePropertyAll(Size.fromWidth(double.maxFinite))),
                  onPressed: () async{
                    controller.navigateToLogin(controller.registerNumber);
                    controller.fireStore();
                  },
                  child: const Text('Add Data',style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
        ),
    ));
  }
}


