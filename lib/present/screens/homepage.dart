import 'package:bookbinnepal/present/screens/profile/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Add product/addproduct.dart';
import 'Message/Message.dart';
import 'Notification/Notifications.dart';
import 'View product/viewproduct.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  int index = 0;
  final screens =[
    const AddProduct(),
    const viewproduct(),
    const Chats(),
    const Notifications(),
     Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        //key: navigationkey,
        height:50,
        color: const Color(0x9AC2C2C2),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromRGBO(174, 140, 199, 1.0),
        items: const <Widget>[
          Icon(Icons.add, size: 30,),
          Icon(Icons.list, size: 30,),
          Icon(Icons.chat, size: 30,),
          Icon(Icons.notifications, size: 30,),
          Icon(Icons.person, size: 30,),
        ],
        animationDuration: const Duration(
            milliseconds: 300
        ),
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
