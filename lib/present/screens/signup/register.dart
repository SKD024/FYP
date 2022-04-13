import 'package:bookbinnepal/present/screens/login/loginscreen.dart';
import 'package:bookbinnepal/present/screens/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);
  static var econtroller = TextEditingController();
  static var pcontroller = TextEditingController();

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

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
      await auth.createUserWithEmailAndPassword(
          email: register.econtroller.text,
          password: register.pcontroller.text);
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerifyEmail()),
      );
    } on FirebaseAuthException catch (e) {
      final snackMessage = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackMessage);
    }
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
                      // Container(
                      //   padding:
                      //   const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      //   child: TextFormField(
                      //     controller: register.econtroller,
                      //     style: TextStyle(
                      //       color: Theme.of(context).primaryColor,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 22,
                      //     ),
                      //     decoration: const InputDecoration(
                      //       border: InputBorder.none,
                      //       prefixIcon: Icon(
                      //         Icons.person_outlined,
                      //         size: 30,
                      //       ),
                      //       labelText: "Name",
                      //       labelStyle: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                      // Container(
                      //   padding:
                      //   const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      //   child: TextFormField(
                      //     style: TextStyle(
                      //       color: Theme.of(context).primaryColor,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 22,
                      //     ),
                      //     decoration: const InputDecoration(
                      //       border: InputBorder.none,
                      //       prefixIcon: Icon(
                      //         Icons.phone,
                      //         size: 30,
                      //       ),
                      //       labelText: "Phone",
                      //       labelStyle: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
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

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text(''),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Center(child: Text("Registered successfully!")),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => loginpage()),
          );
        },
        child: const Text('Close'),
      ),
    ],
  );
}
