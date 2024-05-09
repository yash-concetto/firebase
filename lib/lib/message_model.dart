import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Message {
  String? Id_userUid;
  dynamic message;
  Timestamp? time;
  bool? isReceiver;
  RxBool? checkConnection;
  String? number;

  Message({this.Id_userUid,this.time,this.message,this.isReceiver,this.number,this.checkConnection});

  Message.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    Id_userUid = json['Id_userUid'];
    message = json['message'];
    time = json['time'];
    isReceiver = json['isReceiver'];
    checkConnection = json['checkConnection'];
  }

  // Map<String, dynamic> toMap() => {
  //   'Id_userUid': Id_userUid,
  //   'message': message,
  //   'time': time,
  //   'isYou': isReceiver,
  // };
}