// chat_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final messages = <String>[].obs;
  final textController = TextEditingController();

  void connectAndListen() {
    final socket = IO.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
    });

    // Listen for messages from the server
    socket.on('message', (data) {
      messages.add(data);
    });
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(message);
      // Emit the message to the server
      IO.io('http://localhost:3001', <String, dynamic>{
        'transports': ['websocket'],
      }).emit('message', message);
      textController.clear();
    }
  }
}
