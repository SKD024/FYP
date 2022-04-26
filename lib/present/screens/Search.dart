import 'dart:convert';
import 'package:bookbinnepal/present/screens/viewdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Models/productmodel.dart';

class SearchUser extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: getProductList(query: query),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) {
          return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ));
        } else {
          if (noData == false) {
            return Column(
              children: [
                Flexible(
                  child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            int pId = snapshot.data[index].id;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProduct(
                                      id: pId,
                                    )));
                          },
                          child: Card(
                            color: Colors.purple.shade200,

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text(
                                  '${snapshot.data[index].title}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'author: ${snapshot.data[index].author}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),

                                Text(
                                  'genre: ${snapshot.data[index].genre}',
                                  style: const TextStyle(
                                  fontSize: 15,
                                ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Sorry'),
                  Text('No Data found !'),
                ],
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
           Text ('Search Books by their ', style: TextStyle(fontSize: 16),),
           SizedBox(height: 5,),
           Text ('Name, author and genre', style: TextStyle(fontSize: 16),)
        ],
      ),
    );
  }

  bool noData=false;
  String get url => "http://10.0.2.2:8000/apis/v1/";
  Future<List<ProductModel>> getProductList({String? query}) async {
    Response response = await get(
      Uri.parse(url),
    );
    List<ProductModel> productDetails = [];
    // print(productResponseData);

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var i in data) {
          ProductModel products = ProductModel(
            id: i['id'],
            title: i['title'],
            author: i['author'],
            genre: i['genre'],
          );

          if (query != null) {
            if (products.title!.toLowerCase().contains(query.toLowerCase()) ||
                products.author!.toLowerCase().contains(query.toLowerCase()) ||
                products.genre!.toLowerCase().contains(query.toLowerCase())
            ){
              productDetails.add(products);
            }
          }

        }
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    if(productDetails.isEmpty){
      noData = true;
    }
    return productDetails;
  }
}