import 'dart:convert';

import 'package:bookbinnepal/present/screens/login/loginscreen.dart';
import 'package:bookbinnepal/present/screens/verify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../usermodel.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);
  static var econtroller = TextEditingController();
  static var pcontroller = TextEditingController();
  static var namecontroller = TextEditingController();
  static var phonecontroller = TextEditingController();
  static var addcontroller = TextEditingController();

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String url = "http://10.0.2.2:8000/apis/v1/user/";
  final firestore=FirebaseFirestore.instance;


  void validate() {
    if (formKey.currentState!.validate()) {
      registers();
    } else {
      const snackBar = SnackBar(content: Text('Please! fill all the field.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  registers() async {
    try {
      User? user= (await auth.createUserWithEmailAndPassword(
      // await auth.createUserWithEmailAndPassword(
          email: register.econtroller.text,
          password: register.pcontroller.text)) .user;

      if(user!= null){
        user.updateDisplayName(register.namecontroller.value.text);

        await firestore.collection('users').doc(auth.currentUser!.uid).set({
          "userId": auth.currentUser!.uid,
          "email": auth.currentUser!.email,
          "contact": register.phonecontroller.value.text,
          "name": register.namecontroller.value.text,
        });

        await Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => VerifyEmail()),
               );
      }

    } on FirebaseAuthException catch (e) {
      final snackMessage = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackMessage);
    }
  }


  profile() async {
    String name = register.namecontroller.value.text;
    String phone = register.phonecontroller.value.text;
    String address = register.addcontroller.value.text;
    String email = register.econtroller.value.text;
    // String UserId = auth.currentUser!.uid;

    Users postProduct = Users(
      name: name,
      email: email,
      phonenumber: phone,
      address: address,
    );

    var response = await post(Uri.parse(url),
        body: json.encode(postProduct),
        headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                            iconSize: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'create new account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: register.econtroller,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.mail,
                              size: 30,
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: register.namecontroller,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 30,
                            ),
                            labelText: "Name",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: register.pcontroller,
                          obscureText: true,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 30,
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: register.phonecontroller,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30,
                            ),
                            labelText: "PhoneNumber",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: register.addcontroller,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.home,
                              size: 30,
                            ),
                            labelText: "Address",
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            profile();
                            validate();
                          },
                          child: const Text(
                            "create account",
                            style: TextStyle(color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have a account?",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}