import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  const textfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
          hintText: 'Enter your name'),
    );
  }
}
