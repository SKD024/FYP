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
  //final navigationkey = GlobalKey<CurvedNavigationBasrState>();
  int index = 0;
  final screens =[
    AddProduct(),
    viewproduct(),
    Message(),
    Noti(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        //key: navigationkey,
        height:50,
        color: const Color.fromRGBO(130, 47, 175, 1),
        backgroundColor: Colors.white,
        buttonBackgroundColor: const Color.fromRGBO(130, 47, 175, 1),
        items: const <Widget>[
          Icon(Icons.add, size: 30, color: Colors.white,),
          Icon(Icons.list, size: 30,color: Colors.white,),
          Icon(Icons.chat, size: 30,color: Colors.white,),
          Icon(Icons.notifications, size: 30,color: Colors.white,),
          Icon(Icons.person, size: 30,color: Colors.white,),
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
