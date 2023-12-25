import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import '../controllers/chat_controller.dart';
import '../controllers/internet_connectivity_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final ChatController chatController = Get.put(ChatController());

  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Socket.IO Chat'),
      ),
      body: Obx(() {
        return Column(
        children: <Widget>[
          Expanded(
            child: DashChat(
              messages: chatController.messages
                  .map((message) => ChatMessage(
                      text: message,
                      user: ChatUser(id: '2'),
                      createdAt: DateTime.now()))
                  .toList(),
              onSend: (message) {
                print(message.text);
                // You can access the message text using message.text
                if (message.text != null) {
                  // Send the message using WebSocketController
                  chatController.sendMessage(message.text!);
                }
              },
              currentUser: ChatUser(id: '1'),
              inputOptions: InputOptions(
                  textController: chatController.textController,
                  alwaysShowSend: true),
            ),
          ),
        ],
      );
      })
    );
  }
}
