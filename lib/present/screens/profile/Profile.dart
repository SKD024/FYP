//Profile
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../productmodel.dart';
import '../../usermodel.dart';
import '../Add product/addproduct.dart';
import '../login/loginscreen.dart';
import '../viewdetails.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(child:  Text('User profile')),
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
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:  Color.fromRGBO(174, 140, 199, 1.0),
                            ),
                            child: const Icon(Icons.person_outline,
                              size: 100,
                              color: Color.fromRGBO(83, 82, 82, 1.0),),
                          ),
                          Container(
                            height: 330,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(height: 15,),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  elevation: 10,
                                  color: Colors.white,
                                  child:  SizedBox(
                                    height: 50,
                                    child: Center(child: Text(' ${snapshot.data[index].name}',style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(109, 107, 107, 1.0),
                                    ),),),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  elevation: 10,
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(child: Text('${snapshot.data[index].email}',style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(109, 107, 107, 1.0),
                                    ),),),
                                  ),
                                ),const SizedBox(height: 20),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  elevation: 10,
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 50,
                                    child:   Center(child:  Text('${snapshot.data[index].phonenumber}',style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(109, 107, 107, 1.0),
                                    ),),),
                                  ),
                                ),const SizedBox(height: 20),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  elevation: 10,
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 50,
                                    child:   Center(child:  Text('${snapshot.data[index].address}',style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(109, 107, 107, 1.0),
                                    ),),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(174, 140, 199, 1.0)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    )),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(174, 140, 199, 1.0)),
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => loginpage()),
                                        (Route<dynamic> route) => false);
                              },
                              child: const Text('Logout')),
                          const SizedBox(height: 15,)
                        ],
                      );
                    }
                    return const Padding(padding: EdgeInsets.all(3.0),);
                  },);
              }
            }),
        // ],
      ),
    );
  }
}