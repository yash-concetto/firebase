import 'package:firebase/firebase_options.dart';
import 'package:firebase/lib/Ui/login_screen.dart';
import 'package:firebase/lib/Ui/otp_screen.dart';
import 'package:firebase/lib/Ui/phone_screen.dart';
import 'package:firebase/lib/Ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lib/Ui/chat_screen.dart';
import 'lib/Ui/signup_screen.dart';
import 'lib/controller/signup_controller.dart';

final c = Get.put(SignUpController());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  // Get.put(SignUpController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Flutter Demo',
      themeMode: ThemeMode.system,

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/phone', page: () => const PhoneScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/otp', page: () => const OtpScreen()),
        GetPage(name: '/sign', page: () => const SignUpScreen()),
        GetPage(name: '/chat', page: () => const ChatScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
