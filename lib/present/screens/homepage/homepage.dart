// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// import '../Add product/addproduct.dart';
// import '../View product/viewproduct.dart';
//
// class homepage extends StatefulWidget {
//   homepage({Key? key}) : super(key: key);
//
//   @override
//   State<homepage> createState() => _homepageState();
// }
//
// class _homepageState extends State<homepage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(130, 47, 175, 1),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                     style: TextButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       backgroundColor: const Color.fromRGBO(130, 47, 175, 1),
//                       padding: const EdgeInsets.all(10.0),
//                       primary: Colors.black,
//                       textStyle: const TextStyle(fontSize: 15),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AddProduct()),
//                       );
//                     },
//                     child: const Text(
//                       'Sell',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                       ),
//                     )),
//                 SizedBox(width: 70),
//                 TextButton(
//                     style: TextButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       backgroundColor: const Color.fromRGBO(130, 47, 175, 1),
//                       padding: const EdgeInsets.all(10.0),
//                       primary: Colors.black,
//                       textStyle: const TextStyle(fontSize: 15),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => viewproduct()),
//                       );
//                     },
//                     child: const Text(
//                       'Buy',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                       ),
//                     )),
//               ],
//             ),
//           ],
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           height:50,
//           color: Colors.white,
//           backgroundColor: const Color.fromRGBO(130, 47, 175, 1),
//           buttonBackgroundColor: Colors.white,
//           items: const <Widget>[
//             Icon(Icons.add, size: 30),
//             Icon(Icons.list, size: 30),
//             Icon(Icons.chat, size: 30),
//             Icon(Icons.notifications, size: 30),
//             Icon(Icons.person, size: 30),
//           ],
//           animationDuration: const Duration(
//             milliseconds: 300
//           ),
//           onTap: (index) {
//             var page = "$index";
//             debugPrint("Current Index is $page");
//             if(page == "0"){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddProduct()),
//               );
//             }else if( page=="1"){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => viewproduct()),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
