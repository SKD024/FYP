import 'package:bookbinnepal/present/screens/Add%20product/addproduct.dart';
import 'package:bookbinnepal/present/screens/View%20product/viewproduct.dart';
import 'package:bookbinnepal/present/screens/homepage/homepage.dart';
import 'package:bookbinnepal/present/screens/signup/register.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginform.dart';

class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(130, 47, 175, 1),
                        fontSize: 40,
                        //fontFamily:
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    loginform(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Color.fromRGBO(130, 47, 175, 1),
                              padding: const EdgeInsets.all(10.0),
                              primary: Colors.black,
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage()),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )),
                        const SizedBox(
                          width: 40,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(130, 47, 175, 1),
                              padding: const EdgeInsets.all(10.0),
                              primary: Colors.black,
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register()),
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
