
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login/loginscreen.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(child: Text('Account')),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(
                Icons.person_outline,
                size: 100,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Sandip Kadariya",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    user.email!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(174, 140, 199, 1.0)
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(174, 140, 199, 1.0)
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginpage()),
                    );
                  },
                  child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
