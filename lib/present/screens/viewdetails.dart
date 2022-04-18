import 'dart:convert';
import 'package:bookbinnepal/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../productmodel.dart';
import '../../NotificationModel.dart';

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
  String? image;
  String? postemail;
  String? genre;
  String? author;
  String? condition;
  String? price;

  bool isWaiting = true;
  Future<List<ProductModel>> _getSpecificProductList() async {
    isWaiting = false;
    Response response = await get(
      Uri.parse('$url/${widget.id}'),
    );
    var productResponseData = jsonDecode(response.body);
    List<ProductModel> productDetails = [];
    ProductModel products = ProductModel(
      id: productResponseData['id'],
      title: productResponseData['title'],
      description: productResponseData['description'],
      image: productResponseData['image'],
      postemail: productResponseData['postemail'],
      genre: productResponseData['genre'],
      author: productResponseData['author'],
      condition: productResponseData['condition'],
      price: productResponseData['price'],
    );
    setState(() {
      id = productResponseData['id'];
      title = productResponseData['title'];
      description = productResponseData['description'];
      image = productResponseData['image'];
      postemail = productResponseData['postemail'];
      genre= productResponseData['genre'];
      author= productResponseData['author'];
      condition= productResponseData['condition'];
      price= productResponseData['price'];
    });

    productDetails.add(products);

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
        title: const Text('Product'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image(image: NetworkImage(isWaiting ? '?' : image.toString(),),
                height: 400,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
                const SizedBox(height: 20,width: 20,),
                // Text(
                //   widget.id.toString(),
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
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
                Text(
                  isWaiting
                      ? '?'
                      : 'Posted by: ${postemail.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'Genre: ${genre.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'author: ${author.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'Price: ${price.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'condition: ${condition.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,width: 20,),
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
    );
  }
}