import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../productmodel.dart';
import '../../usermodel.dart';
import '../Add product/addproduct.dart';
import '../viewdetails.dart';

class viewproducts extends StatefulWidget {
  const viewproducts({Key? key}) : super(key: key);

  @override
  State<viewproducts> createState() => _viewproductState();
}

class _viewproductState extends State<viewproducts> {
  String url = "http://10.0.2.2:8000/apis/v1/user/";
  Future<List<Users>> _getProductList() async {
    Response response = await get(
      Uri.parse(url),
    );
    var productResponseData = jsonDecode(response.body);
    List<Users> userdetails = [];
    for (var i in productResponseData) {
      Users user = Users(
        name: i['name'],
        phonenumber: i['phonenumber'],
        address: i['address'],
        email: i['email'],
      );

      userdetails.add(user);
      //print(productDetails);
    }

    return userdetails;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(161, 78, 203, 1.0),
          title: Center(child: const Text('View Products')),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
            future: _getProductList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.black),
                    ));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
    if ('${snapshot.data[index].email}' ==
    FirebaseAuth.instance.currentUser!.email) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 150,
                          child: GestureDetector(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shadowColor: Color.fromRGBO(133, 13, 189, 1.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                elevation: 10,
                                color: const Color.fromRGBO(224, 219, 236, 1.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(155, 45, 215, 100.0),
                                        Color.fromRGBO(220, 218, 218, 1.0)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      leading: Text(
                                        'name: ${snapshot.data[index].name}',
                                        style: const TextStyle(
                                            color: Color(0xFF0A0000),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      title: Text(
                                        'email: ${snapshot.data[index].email}',
                                        style: const TextStyle(
                                            color: Color(0xFF0A0000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        'address: ${snapshot.data[index].address}',
                                        style: const TextStyle(
                                            color: Color(0xFF0A0000),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Text(
                                        'phonenumber: ${snapshot.data[index].phonenumber}',
                                        style: const TextStyle(
                                            color: Color(0xFF0A0000),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                              }),
                        ),
                      );
                    }
                    return const Padding(padding: EdgeInsets.all(8.0),);
                    },);
              }
            }),
        // ],
      ),
    );
  }
}
