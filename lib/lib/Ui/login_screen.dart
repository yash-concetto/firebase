import 'package:firebase/lib/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         // Get.toNamed("/phone");
          //       },
          //       icon: Icon(
          //         Icons.login_outlined,
          //         color: Colors.white,
          //       )),
          // ],
          backgroundColor: Colors.deepPurple,
          title: const Center(
              child: Text(
            'Login Screen',
            style: TextStyle(color: CupertinoColors.white),
          ))),
        body:
        // Form(
      // key: controller.LoginFormKey,
      // child:
      Padding(
        padding: const EdgeInsets.only(top: 60,left: 15,right: 15),
        child: SingleChildScrollView(
          child:  Obx(() => Column(
            children: [
              TextFormField(
                controller: controller.number,
                decoration: const InputDecoration(labelText: 'Number',prefixIcon: Icon(Icons.phone)),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: controller.password,
                obscureText: controller.passwordVisible.value,
                decoration:  InputDecoration(labelText: 'Password',prefixIcon: IconButton(
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
                    controller.check();
                  },
                  child: const Text('Login',style: TextStyle(color: Colors.white),)),
              const SizedBox(height: 60),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(CupertinoColors.systemIndigo),
                      fixedSize: MaterialStatePropertyAll(Size.fromWidth(double.maxFinite))),
                  onPressed: () async{
                    // controller.check();
                    controller.navigateToSign();
                  },
                  child: const Text('New Register',style: TextStyle(color: Colors.white),)),

            ],
          ),
          ),
        ),
      // ),
    ));
  }
}
