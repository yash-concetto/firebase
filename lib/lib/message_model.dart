import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Message {
  String? Id_userUid;
  dynamic message;
  Timestamp? time;
  int? uniqueId;
  bool? isReceiver;
  RxBool? isDelete = false.obs;
  RxBool? seenMessage = false.obs;
  String? receiverNumber;

  Message(
      {this.Id_userUid, this.uniqueId, this.time, this.message, this.isReceiver, this.receiverNumber})
      :seenMessage=false.obs,
        isDelete = false.obs;

  Message.fromJson(Map<String, dynamic> json) {
    receiverNumber = json['receiverNumber'];
    uniqueId = json['uniqueId'];
    Id_userUid = json['Id_userUid'];
    message = json['message'];
    time = json['time'];
    isReceiver = json['isReceiver'];
    seenMessage?.value = json['seenMessage'];
    isDelete?.value = json['isDelete'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Message &&
              runtimeType == other.runtimeType &&
              uniqueId == other.uniqueId &&
              Id_userUid == other.Id_userUid &&
              message == other.message &&
              time == other.time &&
              message == other.message &&
              isReceiver == other.isReceiver &&
              receiverNumber == other.receiverNumber;

  @override
  int get hashCode =>
      uniqueId.hashCode ^
      Id_userUid.hashCode ^
      message.hashCode ^
      time.hashCode ^
      message.hashCode ^
      isReceiver.hashCode ^
      receiverNumber.hashCode;
}