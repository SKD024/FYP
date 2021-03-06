import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:bookbinnepal/present/Models/productmodel.dart';
import '../Search.dart';
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
    print(response.body);
    var productResponseData = jsonDecode(response.body);
    List<ProductModel> productDetails = [];
    for (var i in productResponseData) {
      ProductModel products = ProductModel(
        id: i['id'],
        title: i['title'],
        description: i['description'],
        image: i['image'],
        postemail: i['postemail'],
        genre: i['genre'],
        author: i['author'],
        price: i['price'],
        condition: i['condition'],
        isverified: i['isverified'],
      );

      productDetails.add(products);
    }
    print(productDetails);

    return productDetails;
  }

  @override
  void initState() {
    _getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(
            child: Text('View Books'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchUser());
                },
                icon: const Icon(
                  CupertinoIcons.search_circle_fill,
                  size: 38,
                ))
          ],
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: _getProductList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return const Center(
                  child: Text(
                "Loadings... ",
                style: TextStyle(color: Colors.black),
              ));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data[index].isverified == true) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 150,
                          child: GestureDetector(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shadowColor:
                                    const Color.fromRGBO(133, 13, 189, 1.0),
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
                                      leading: SizedBox(
                                        // height: 250,
                                        // width: 150,
                                        child: Image.network(
                                          '${snapshot.data[index].image}',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(
                                        'Title: ${snapshot.data[index].title}',
                                        style: const TextStyle(
                                            color: Color(0xFF0A0000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        'Description: ${snapshot.data[index].description}',
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
                                int pId = snapshot.data[index].id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProduct(
                                            id: pId,
                                          )),
                                );
                              }),
                        ),
                      );
                    } else {
                      return const Padding(padding: EdgeInsets.all(0));
                    }
                  });
            }
          },
        ),
        // ],
      ),
    );
  }
}
