import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
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
                  Get.toNamed("/login", arguments: controller.number);
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
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (controller
                              .messageList[index].isReceiver! /*== "receiver"*/
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: (controller.messageList[index]
                                  .isReceiver! /*== "receiver"*/
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            controller.messageList[index].isReceiver!
                                ? Column(
                                    children: [
                                      Text(controller.messageList[index].Id_userUid!, style: const TextStyle(fontSize: 5),),
                                      Text(controller.messageList[index].message, style: const TextStyle(fontSize: 15),),
                                    ],
                                  )
                                : Text(controller.messageList[index].message, style: const TextStyle(fontSize: 15),),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    time,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.done_all),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

