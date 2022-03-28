import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(130, 47, 175, 1),
            title: Center(child: const Text('Messages')),
            automaticallyImplyLeading: false,
          ),
      ),
    );
  }
}
