import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../NotificationModel.dart';
import '../Message/Chatroom.dart';

//import 'NotificationModel.dart';
//import 'ip/ip_address.dart';
//import 'messaging_page.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  static String id = "notification_page";
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String url = 'http://10.0.2.2:8000/apis/v1/request/';
  String? updateId;
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NotificationModel>> _getRequestList() async {
    Response response = await get(
      Uri.parse(url),
    );
    var requestResponseData = jsonDecode(response.body);
    List<NotificationModel> requestDetails = [];
    for (var i in requestResponseData) {
      NotificationModel requests = NotificationModel(
          id: i['id'],
          title: i['title'],
          description: i['description'],
          postUserId: i['postUserId'],
          requestUserId: i['requestUserId'],
          postEmail: i['postEmail'],
          requestEmail: i['requestEmail'],
          isAccepted: i['isAccepted'],);
      requestDetails.add(requests);
      // print(requestDetails);
    }
    return requestDetails;
  }

  Future<Response> updateProduct() async {
    Response response = await get(
      Uri.parse('$url$updateId/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var responseData = jsonDecode(response.body);
    int id = responseData['id'];
    String title = responseData['title'];
    String postUserId = responseData['postUserId'];
    String requestUserId = responseData['requestUserId'];
    String postEmail = responseData['postEmail'];
    String requestEmail = responseData['requestEmail'];
    String description = responseData['description'];

    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseUpdate = await put(
        Uri.parse('$url$updateId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'postUserId': postUserId,
          'postEmail': postEmail,
          'requestUserId': requestUserId,
          'requestEmail': requestEmail,
          'description': description,
          'isAccepted': 'true',
        }),
      );
      if (responseUpdate.statusCode == 200) {
        setState(() {});
      }
    } else {
      const snackBar =
      SnackBar(content: Text('The Product could not be accepted!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  String chatRoomId(String user1, String user2) {
    if (user1.toLowerCase().hashCode > user2.toLowerCase().hashCode) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
              title: const Text('Notification'),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.arrow_downward_rounded,
                    ),
                    text: 'Inbox',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.arrow_upward_rounded,
                    ),
                    text: 'Outbox',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                inboxpage(),
                outboxpage(),
              ],
            ),
          ),
        ));
  }

  Widget inboxpage() {
    return FutureBuilder(
        future: _getRequestList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: Text(
                  "No Data Found...",
                  style: TextStyle(color: Colors.black),
                ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if ('${snapshot.data[index].postUserId}' ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 150,
                        child: Container(
                          width: 300,
                          height: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // color: Color(0xEAFFFFFF).withOpacity(0.2),
                            color: const Color(0xEAFFFFFF),

                            // Card(
                            //   shadowColor: Colors.black,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(20.0)),
                            //   elevation: 10,
                            //   color: const Color(0xFFF1F1F1),
                            child: Center(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Text(
                                      'title \n'
                                          '${snapshot.data[index].title}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        foreground: Paint()
                                          ..style = PaintingStyle.fill
                                        // ..style = PaintingStyle.fill
                                          ..strokeWidth = 6
                                          ..color =
                                          const Color.fromRGBO(161, 78, 203, 1.0),
                                      ),
                                    ),
                                    title: Text(
                                      'description: '
                                          '${snapshot.data[index].description}',
                                      style: const TextStyle(
                                          color: Color(0xFF003049),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // trailing: IconButton(
                                    //     icon: Icon(Icons.delete,
                                    //         color: Colors.red),
                                    //     onPressed: () {
                                    //       // deleteId = snapshot.data[index].id;
                                    //       // deleteProduct();
                                    //     }),
                                  ),
                                  if (snapshot.data[index].isAccepted ==
                                      true) ...[
                                    ElevatedButton(
                                      // style: kButtonStyle,
                                      onPressed: () async {
                                        await _firestore
                                            .collection('users')
                                            .where("email",
                                            isEqualTo: snapshot.data[index]
                                                .requestEmail)
                                            .get()
                                            .then((value) {
                                          setState(() {
                                            userMap = value.docs[0].data();
                                          });
                                        });
                                        String roomId = chatRoomId(
                                            _auth.currentUser!.email!,
                                            userMap!['email']);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ChatRoom(
                                              chatRoomId: roomId,
                                              userMap: userMap!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Chat'),
                                    ),
                                  ] else ...[
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          // style: kButtonStyle,
                                          onPressed: () {
                                            updateId = snapshot.data[index].id
                                                .toString();
                                            updateProduct();
                                          },
                                          child: const Text("accept"),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        ElevatedButton(
                                          // style:
                                          // kButtonStyleDecline,
                                            onPressed: () {},
                                            child: const Text("decline"))
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(0),
                  );
                });
          }
        });
  }

  Widget outboxpage() {
    return FutureBuilder(
        future: _getRequestList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: Text(
                  "No Data Found...",
                  style: TextStyle(color: Colors.black),
                ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if ('${snapshot.data[index].requestUserId}' ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 150,
                        child: Container(
                          width: 300,
                          height: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // color: Color(0xEAFFFFFF).withOpacity(0.2),
                            color: const Color(0xEAFFFFFF),

                            // Card(
                            //   shadowColor: Colors.black,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(20.0)),
                            //   elevation: 10,
                            //   color: const Color(0xFFF1F1F1),
                            child: Center(
                              child: Column(children: [
                                ListTile(
                                  leading: Text(
                                    'title \n'
                                        '${snapshot.data[index].title}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      foreground: Paint()
                                        ..style = PaintingStyle.fill
                                      // ..style = PaintingStyle.fill
                                        ..strokeWidth = 6
                                        ..color =
                                        const Color.fromRGBO(161, 78, 203, 1.0),
                                    ),
                                  ),
                                  title: Text(
                                    'description: '
                                        '${snapshot.data[index].description}',
                                    style: const TextStyle(
                                        color: Color(0xFF003049),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: IconButton(
                                      icon:
                                      const Icon(Icons.delete, color: Colors.grey),
                                      onPressed: () {
                                        // deleteId = snapshot.data[index].id;
                                        // deleteProduct();
                                      }),
                                ),
                                // if (snapshot.data[index].isAccepted ==
                                //     true) ...[
                                //   ElevatedButton(
                                //     // style: kButtonStyle,
                                //     onPressed: () async {
                                //       await _firestore
                                //           .collection('users')
                                //           .where("email",
                                //           isEqualTo: snapshot.data[index]
                                //               .requestEmail)
                                //           .get()
                                //           .then((value) {
                                //         setState(() {
                                //           userMap = value.docs[0].data();
                                //         });
                                //       });
                                //       String roomId = chatRoomId(
                                //           _auth.currentUser!.email!,
                                //           userMap!['email']);
                                //       Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //           builder: (_) => ChatRoom(
                                //             chatRoomId: roomId,
                                //             userMap: userMap!,
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //     child: const Text('Chat'),
                                //   ),
                                // ] else ...[
                                //   Row(
                                //     children: [
                                //       ElevatedButton(
                                //         // style: kButtonStyle,
                                //         onPressed: () {
                                //           updateId = snapshot.data[index].id
                                //               .toString();
                                //           updateProduct();
                                //         },
                                //         child: const Text("Accept"),
                                //       ),
                                //       const SizedBox(
                                //         width: 30,
                                //       ),
                                //       ElevatedButton(
                                //         // style:
                                //         // kButtonStyleDecline,
                                //           onPressed: () {},
                                //           child: const Text("Decline"))
                                //     ],
                                //   ) ],
                              ] ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(0),
                  );
                });
          }
        });
  }
}