import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../productmodel.dart';

class DetailProduct extends StatefulWidget {
  final int id;
  const DetailProduct({required this.id});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String url = "http://10.0.2.2:8000/apis/v1";
  int? id;
  String? title;
  String? description;

  bool isWaiting = true;
  Future<List<ProductModel>> _getSpecificProductList() async {
    isWaiting = false;
    Response response = await get(
      Uri.parse('$url/${widget.id}'),
    );
    var productResponseData = jsonDecode(response.body);
    //print(response.statusCode);
    //print(productResponseData);
    List<ProductModel> productDetails = [];
    // for (var i in productResponseData) {
    ProductModel products = ProductModel(
      id: productResponseData['id'],
      title: productResponseData['title'],
      description: productResponseData['description'],
      // image: productResponseData['image'],
    );
    setState(() {
      id = productResponseData['id'];
      title = productResponseData['title'];
      description = productResponseData['description'];

      // disImage = productResponseData['image'];
    });

    productDetails.add(products);
    // print(productDetails);
    // }

    return productDetails;
  }
  @override
  void initState() {
    super.initState();
    _getSpecificProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: appbarColor,
        title: const Text('Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.id.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isWaiting ? '?' : 'Name: ${title.toString()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isWaiting
                        ? '?'
                        : 'Description: ${description.toString()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Expanded(
                  //     child: Image(
                  //         image: NetworkImage(isWaiting
                  //             ? 'https://picsum.photos/250?image=9'
                  //             : disImage.toString()))),
                  ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF41AAB9),
                        ),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF41AAB9),
                        ),
                      ),
                      onPressed: () {
                        //requestProduct();
                      },
                      child: const Text('Buy'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}