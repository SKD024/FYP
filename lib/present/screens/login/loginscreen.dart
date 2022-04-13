import 'package:bookbinnepal/present/screens/signup/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import '../homepage.dart';
import '../verify.dart';


class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);
  static var emailcontroller = TextEditingController();
  static var passwordcontroller = TextEditingController();
  //static String id = "login page";

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  final auth = FirebaseAuth.instance;
  late User user;
  final formKey = GlobalKey<FormState>();

  void validate() {
    if (formKey.currentState!.validate()) {
      login();
      // Navigator.pushNamed(context, OTPVerification.id);
    } else {
      final snackBar = SnackBar(content: Text('Please! fill all the field.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool value = false;
  Map? _userData;
  String provider = '';
  // facebookSignIn() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   if (result.status == LoginStatus.success) {
  //     provider = 'facebook';
  //     final userData = await FacebookAuth.i.getUserData(
  //       fields: "email,name,id",
  //     );
  //     setState(() {
  //       _userData = userData;
  //     });
  //     print(_userData);
  //     print(provider);
  //     //Navigator.pushNamed(context, GoogleMapScreen.id);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Homepage()),
  //     );
  //   } else {
  //     print('login unsuccessful');
  //   }
  // }
  login() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: loginpage.emailcontroller.text,
          password: loginpage.passwordcontroller.text);
      user = auth.currentUser!;
      await user.reload();
      if (user.emailVerified) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerifyEmail()));
      }
    } on FirebaseAuthException catch (e) {
      final snackMessage = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackMessage);
    }
  }
  DateTime pre_backpress = DateTime.now();

  @override
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Icon(
                      Icons.person_outline,
                      //color: Colors.grey,
                      color: Color.fromRGBO(193, 108, 231, 1.0),
                      size: 140,
                    ),
                    const SizedBox(height: 13),
                    const Text(
                      'BookBin Nepal',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        controller: loginpage.emailcontroller,
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
                        controller: loginpage.passwordcontroller,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     "Forgot password",
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //       color: Theme.of(context).primaryColor,
                        //     ),
                        //   ),
                        // ),
                      ],
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
                          "Login",
                          style: TextStyle(color: Colors.white),
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
                          "Don't have a account?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => register()),
                            );
                          },
                          child: Text(
                            "Register",
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
    );
  }
}
