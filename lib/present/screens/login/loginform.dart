import 'package:flutter/material.dart';

class loginform extends StatefulWidget {
  loginform({Key? key}) : super(key: key);

  @override
  State<loginform> createState() => _loginformState();
}

class _loginformState extends State<loginform> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email address.",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                filled: true,
                fillColor: Color.fromARGB(255, 236, 202, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              obscureText: _obscureText,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password.",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    print('The eye visibility is working.');
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                filled: true,
                fillColor: Color.fromARGB(255, 236, 202, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
