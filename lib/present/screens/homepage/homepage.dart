import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Add product/addproduct.dart';
import '../View product/viewproduct.dart';

class homepage extends StatefulWidget {
  homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromRGBO(130, 47, 175, 1),
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.black,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                    child: const Text(
                      'Sell',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
                SizedBox(width: 70),
                TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromRGBO(130, 47, 175, 1),
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.black,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => viewproduct()),
                      );
                    },
                    child: const Text(
                      'Buy',
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
    );
  }
}
