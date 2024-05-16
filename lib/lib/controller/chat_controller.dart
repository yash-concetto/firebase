import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/lib/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool onCheck = true.obs;
  RxBool otherUserValue = true.obs;
  RxBool isDelete = false.obs;
  String documentId = '';
  String otherId = '';
  String currentId = '';
  RxList<Message> messageList = <Message>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final message = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    currentUser();
    otherUser();
    addToList();
  }

  @override
  void onClose() {
    super.onClose();
    FirebaseFirestore.instance
        .collection('user')
        .doc(currentId)
        .update({'isActive': onCheck.value = false});
  }

  Future<void> activeStatus() async {
    for (int index = 0; index < messageList.length; index++) {
      messageList[index].seenMessage!.value = true;
    }
  }

  Future<void> otherUser() async {
    FirebaseFirestore.instance
        .collection('user')
        .where('Id_usuario',
            isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      otherId = value.docs.first.id;
      final docRef = FirebaseFirestore.instance.collection("user").doc(otherId);
      docRef.snapshots().listen((value) async {
        otherUserValue.value = value['isActive'];
        if (value['isActive'] == true) {
          activeStatus();
        }
      });
    });
  }

  Future<void> openDialog(int id) async {
    Get.dialog(
      AlertDialog(
        title: const Text('Dialog'),
        content: const Text('Confirm to Delete This Message'),
        actions: [
          TextButton(
              child: const Text("Delete"),
              onPressed: () {
                deleteMassage(id);
                Get.back();
              }),
        ],
      ),
    );
  }

  Future<void> deleteMassage(int index) async {
    FirebaseFirestore.instance
        .collection('chat-data')
        .where('uniqueId', isEqualTo: index)
        .get()
        .then((value) async {
      documentId = value.docs.first.id;
      FirebaseFirestore.instance.collection("chat-data").doc(documentId).update({'isDelete': true});
    });
  }

  Future<void> currentUser() async {
    FirebaseFirestore.instance
        .collection('user')
        .where('Id_usuario', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      currentId = value.docs.first.id;
      final docRef =
          FirebaseFirestore.instance.collection("user").doc(currentId);
      docRef.update({'isActive': onCheck.value = true});
    });
  }

  Future<void> addToList() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    // userUid.value = uid;
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
        int index = messageList.indexOf(message);
        if (index == -1) {
            messageList.insert(0, message);
        } else {
          messageList[index] = message;
        }
        print('132 :: ${messageList.length}');
        print('documentChanges ${change.doc.data()}');
      }
    });
  }

  Future<void> fireStore() async {
    final User? user = auth.currentUser;
    final userUid = user!.uid;
    if (message.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance.collection('chat-data').add({
        'message': message.text,
        'time': DateTime.now(),
        'uniqueId': DateTime.now().millisecondsSinceEpoch,
        'Id_userUid': userUid,
        'seenMessage': otherUserValue.value,
        'isDelete': isDelete.value,
      });
    }
  }
}
