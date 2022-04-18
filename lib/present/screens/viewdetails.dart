import 'dart:convert';
import 'package:bookbinnepal/NotificationModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final auth=FirebaseAuth.instance;

  int? id;
  String? Rtitle;
  String? Rdescription;
  String? image;
  String? Rpostemail;
  String? Rgenre;
  String? Rauthor;
  String? Rcondition;
  String? Rprice;
  String? RuserID;

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
      userID: productResponseData['userID'],

    );
    setState(() {
      id = productResponseData['id'];
      Rtitle = productResponseData['title'];
      Rdescription = productResponseData['description'];
      image = productResponseData['image'];
      Rpostemail = productResponseData['postemail'];
      Rgenre= productResponseData['genre'];
      Rauthor= productResponseData['author'];
      Rcondition= productResponseData['condition'];
      Rprice= productResponseData['price'];
      RuserID= productResponseData['userID'];
    });

    productDetails.add(products);

    return productDetails;
  }


  requestProd() async {

    String requestUrl = "http://10.0.2.2:8000/apis/v1/request/";

    String? title = Rtitle;
    String? description= Rdescription;
    String? UserID =RuserID;
    String? requestUserId = auth.currentUser!.uid;
    String? postEmail = Rpostemail;
    String? requestEmail = auth.currentUser!.email;
    String? genre = Rgenre;
    String? author = Rauthor;
    String? price = Rprice;
    String? condition = Rcondition;

    NotificationModel donor = NotificationModel(
      id: 0,
      title: title,
      description: description,
      genre: genre,
      author: author,
      price: price,
      condition: condition,
      requestUserId:requestUserId,
      postUserId:UserID,
      requestEmail:requestEmail,
      postEmail:postEmail,
      isAccepted:false,


    );

    var response = await post(Uri.parse(requestUrl),
        body: json.encode(donor),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      const snackBar = SnackBar(content: Text('The Request has been sent!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar =
      SnackBar(content: Text('The Request could not be sent!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
                  isWaiting ? '?' : 'Name: ${Rtitle.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'Description: ${Rdescription.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'Posted by: ${Rpostemail.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'Genre: ${Rgenre.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'author: ${Rauthor.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'Price: ${Rprice.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isWaiting
                      ? '?'
                      : 'condition: ${Rcondition.toString()}',
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
                      requestProd();
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