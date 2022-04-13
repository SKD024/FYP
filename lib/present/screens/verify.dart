import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

//import 'loginpage.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  static String id = 'verify_email';

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'BookBinNepal',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Text(
                  'An email has been sent to ${user.email} please verify !!')),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()));
    }
  }
}