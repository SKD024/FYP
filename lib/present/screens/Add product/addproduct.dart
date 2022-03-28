import 'dart:convert';
import 'package:bookbinnepal/present/screens/Message/Message.dart';
import 'package:bookbinnepal/present/screens/Notification/Notifications.dart';
import 'package:bookbinnepal/present/screens/profile/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../productmodel.dart';
import '../View product/viewproduct.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static String id = "addproduct_page";
  static var title = TextEditingController();
  static var description = TextEditingController();

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String url = "http://10.0.2.2:8000/apis/v1/";
  addProduct() async {
    String title = AddProduct.title.value.text;
    String description = AddProduct.description.value.text;

    ProductModel postProduct = ProductModel(
      title: title,
      description: description,
    );

    var response = await post(Uri.parse(url),
        body: json.encode(postProduct),
        headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(130, 47, 175, 1),
          title: Center(child: const Text('Add Products')),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: AddProduct.title,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: AddProduct.description,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        const Color(0x82050000),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(130, 47, 175, 1),
                      ),
                    ),
                    onPressed: () {
                      addProduct();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: const Text("Submit")),
              ),
            ],
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
        Center(child: Text("Added Sucessfully!")),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        child: const Text('Close'),
      ),
    ],
  );
}
