import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class ChatController extends GetxController {
  ScrollController scrollController = ScrollController();

  String number = '';

  // RxString number = Get.find<SignUpController>().registerNumber;
  RxList<Message> messageList = <Message>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final message = TextEditingController();


  @override
  void onInit() {
    addToList();
    // number.value = signUpController.registerNumber;
    // Get.lazyPut(() => SignUpController());
    getnumber();
    print(number);
    super.onInit();
  }

  Future<void> getnumber() async{
    number = c.registerNumber;
  }


    Future<void> addToList() async {
      final User? user = auth.currentUser;
      final uid = user!.uid;
      // Query<Map<String, dynamic>> query =
      // FirebaseFirestore.instance.collection('chat-data');
      // query = query.orderBy('time', descending: true);
      // query = query.where('Id_userUid', isEqualTo: uid);
      // query = query.orderBy('time', descending: true);

      Query<Map<String, dynamic>> userQuery = FirebaseFirestore.instance.collection('chat-data');
      userQuery = userQuery.orderBy('time', descending: false);
      userQuery.snapshots().listen((value) {
        for (var change in value.docChanges) {
          Message message = Message.fromJson(change.doc.data()!);
          message.isReceiver = message.Id_userUid != uid;
          messageList.insert(0, message);
          print(messageList.length);
          print('documentChanges ${change.doc.data()}');
          }
      });
    }

    Future<void> fireStore() async {
      final User? user = auth.currentUser;
      final userUid = user!.uid;
      if(message.text.trim().isNotEmpty) {
        await FirebaseFirestore.instance.collection('chat-data').add({
          'message': message.text,
          'time': DateTime.now(),
          'Id_userUid': userUid
        });
      }
    }
  }




