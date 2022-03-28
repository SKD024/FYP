import 'package:flutter/material.dart';
 class Noti extends StatefulWidget {
   const Noti({Key? key}) : super(key: key);
 
   @override
   State<Noti> createState() => _NotiState();
 }
 
 class _NotiState extends State<Noti> {
   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         appBar: AppBar(
           backgroundColor: Color.fromRGBO(130, 47, 175, 1),
           title: Center(child: const Text('Notification')),
           automaticallyImplyLeading: false,
         ),
       ),
     );
   }
 }
 