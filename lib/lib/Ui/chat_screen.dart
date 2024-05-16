import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/chat_controller.dart';

class ChatScreen extends GetView<ChatScreen> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.white,
                )),
          ],
          backgroundColor: Colors.deepPurple,
          title: const Center(
              child: Text(
            'Chat Screen',
            style: TextStyle(color: Colors.white),
          ))),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                reverse: true,
                controller: scrollController,
                itemCount: controller.messageList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                      controller
                          .messageList[index].time!.millisecondsSinceEpoch);
                  final time = DateFormat('hh:mm').format(dateTime);
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (controller.messageList[index].isReceiver!
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        // width: ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: (controller.messageList[index].isReceiver!
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: controller.messageList[index].isReceiver!
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.messageList[index]
                                            .receiverNumber ??
                                        '',
                                    style: const TextStyle(fontSize: 5),
                                  ),
                                  Text(
                                    controller.messageList[index].message,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    time,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              )
                            : InkWell(
                                onLongPress: () {
                                  if(controller.messageList[index].isDelete?.value == false){
                                    controller.openDialog(controller.messageList[index].uniqueId!);
                                  }
                                  const Duration(seconds: 1);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    controller.messageList[index].isDelete?.value == true ?
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.block,color: Colors.black45,size: 15),
                                        Text(
                                          'You Deleted this Message',
                                          style: TextStyle(fontSize: 10,color: Colors.black45),
                                        ),
                                      ],
                                    ): Text(
                                        controller.messageList[index].message,
                                        style: const TextStyle(fontSize: 15,color: Colors.black),
                                      ),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          time,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        const SizedBox(width: 5),
                                        controller.messageList[index]
                                                    .seenMessage?.value ??
                                                false
                                            ? const Icon(
                                                Icons.done_all,
                                                size: 18,
                                                color: Colors.lightBlue,
                                              )
                                            : const Icon(
                                                Icons.done_all,
                                                size: 18,
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      // ),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.message,
                      cursorColor: Colors.redAccent,
                      decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      controller.fireStore();
                      controller.message.clear();
                      if (scrollController.hasClients) {
                        final position =
                            scrollController.position.minScrollExtent;
                        scrollController.jumpTo(position);
                      }
                    },
                    isExtended: true,
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
