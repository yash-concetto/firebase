import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChatController extends GetxController {

  ScrollController scrollController = ScrollController();
  // Message messageModel = Message();
  RxBool checkNetwork = true.obs;
  RxString number = ''.obs;
  RxString userUid = ''.obs;
  // RxString number = Get.find<SignUpController>().registerNumber;
  RxList<Message> messageList = <Message>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  final message = TextEditingController();

  @override
  void onInit() {
    addToList();
    // getNumber();
    print('26::${number}');
    super.onInit();
  }

  // Future<void> getNumber() async {
  //   final User? user = auth.currentUser;
  //   final uid = user!.uid;
  //
  //   Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('user');
  //   query = query.where('Id_usuario', isEqualTo: uid);
  //       await FirebaseFirestore.instance.doc("user").get().
  //       collection('user').doc("number").get().
        // then((value) =>
        //     print('value::${value}')
        // number.value = value['number']
        // );
  // }

  Future<void> addToList() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    userUid.value = uid;
    // Query<Map<String, dynamic>> query =
    // FirebaseFirestore.instance.collection('chat-data');
    // query = query.orderBy('time', descending: true);
    // query = query.where('Id_userUid', isEqualTo: uid);
    // query = query.orderBy('time', descending: true);
    Query<Map<String, dynamic>> userQuery =
    FirebaseFirestore.instance.collection('chat-data');
    userQuery = userQuery.orderBy('time', descending: false);
    userQuery.snapshots().listen((value) async {
      for (var change in value.docChanges) {
        Message message = Message.fromJson(change.doc.data()!);
        message.isReceiver = message.Id_userUid != uid;
        // if(message.Id_userUid != uid) {
        // final val = await checkConnection();
        // print('val::${val}');
        //   message.checkConnection!.value = val;
        // }
        messageList.insert(0, message);
        print(messageList.length);
        print('documentChanges ${change.doc.data()}');
      }
    });
  }

  Future<bool> checkConnection() async {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // messageModel.checkConnection = true;
      // return checkNetwork;
      print('connected');
    }
    return true;
      // checkNetwork.isTrue.obs;
  }

  Future<void> fireStore() async {
    final User? user = auth.currentUser;
    final userUid = user!.uid;
    if (message.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance.collection('chat-data').add({
        'message': message.text,
        'time': DateTime.now(),
        'Id_userUid': userUid
      });
    }
  }
}
