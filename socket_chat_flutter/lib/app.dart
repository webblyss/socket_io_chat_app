import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_chat_flutter/screens/chat_screen.dart';
import 'controllers/chat_controller.dart';
import 'controllers/internet_connectivity_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(ConnectivityController());
        Get.put(ChatController());
      }),
    );
  }
}
