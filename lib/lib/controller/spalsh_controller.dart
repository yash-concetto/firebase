import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
   // navigateToNext();
    super.onInit();
  }

  void navigateToNext(){
    // Get.toNamed('/phone');
    if(FirebaseAuth.instance.currentUser != null){
      Get.toNamed("/chat");
    }else{
      Get.toNamed("/login");
    }
  }

}
