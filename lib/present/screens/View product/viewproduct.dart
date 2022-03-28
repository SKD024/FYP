import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../productmodel.dart';
import '../Add product/addproduct.dart';
import '../viewdetails.dart';

class viewproduct extends StatefulWidget {
  const viewproduct({Key? key}) : super(key: key);

  @override
  State<viewproduct> createState() => _viewproductState();
}

class _viewproductState extends State<viewproduct> {
  String url = "http://10.0.2.2:8000/apis/v1/";
  Future<List<ProductModel>> _getProductList() async {
    Response response = await get(
      Uri.parse(url),
    );
    var productResponseData = jsonDecode(response.body);
    // print(productResponseData);
    List<ProductModel> productDetails = [];
    for (var i in productResponseData) {
      ProductModel products = ProductModel(
        id: i['id'],
        title: i['title'],
        description: i['description'],
      );

      productDetails.add(products);
      print(productDetails);
    }

    return productDetails;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(130, 47, 175, 1),
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
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 150,
                          child: GestureDetector(
                          child: Card(
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 10,
                            color: const Color(0xFFF1F1F1),
                            child: Center(
                              child: ListTile(
                                // leading: Text(
                                //   'ID: ${snapshot.data[index].id}',
                                //   style: const TextStyle(
                                //       color: Color(0xFF003049),
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                title: Text(
                                  'Title: ${snapshot.data[index].title}',
                                  style: const TextStyle(
                                      color: Color(0xFF003049),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  'Description: ${snapshot.data[index].description}',
                                  style: const TextStyle(
                                      color: Color(0xFF003049),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                              onTap: () {int pId = snapshot.data[index].id;Navigator.push(context,MaterialPageRoute(builder: (context) => DetailProduct(id: pId,)),
                              );
                            }
                          ),
                        ),
                      );
                    });
              }
            }),
        // ],
      ),
    );
  }
}
