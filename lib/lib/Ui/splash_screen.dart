import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/spalsh_controller.dart';

class SplashScreen extends GetView<SplashController> {
  final SplashController controller = Get.put(SplashController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: FlutterLogo(
              style: FlutterLogoStyle.markOnly,
              size: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(onPressed:() async{
              controller.navigateToNext();
            },
                child: const Text("Next")),
          )
        ],
      ),
    );
  }
}
