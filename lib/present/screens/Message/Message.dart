import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Chatroom.dart';



class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);
  static String id = 'one-one_chat';

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String chatRoomId(String user1, String user2) {
    if (user1.toLowerCase().hashCode > user2.toLowerCase().hashCode) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: const Text(
          'Chats',
        ),
      ),
      body: isLoading
          ? Center(
          child: SizedBox(
            height: size.height / 20,
            width: size.height / 20,
            child: const CircularProgressIndicator(),
          ))
          : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
              children: [
                // const SizedBox(height: 16,),
                TextField(
                  controller: _search,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: const Text('Search'),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? ListTile(
                  onTap: () {
                    // print(_auth.currentUser!.displayName!);
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
                  leading: const Icon(Icons.account_box,
                      color: Colors.black),
                  title: Text(
                    userMap!['email'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing:
                  const Icon(Icons.chat, color: Colors.black),
                )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}