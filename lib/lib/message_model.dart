import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? Id_userUid;
  dynamic message;
  Timestamp? time;
  bool? isReceiver;

  Message({this.Id_userUid,this.time,this.message,this.isReceiver});

  Message.fromJson(Map<String, dynamic> json) {
    Id_userUid = json['Id_userUid'];
    message = json['message'];
    time = json['time'];
    isReceiver = json['isReceiver'];
  }

  // Map<String, dynamic> toMap() => {
  //   'Id_userUid': Id_userUid,
  //   'message': message,
  //   'time': time,
  //   'isYou': isReceiver,
  // };
}