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
        title: Text(Rtitle.toString()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
            Card(
              clipBehavior: Clip.antiAlias,
              shadowColor: const Color.fromRGBO(224, 4, 167, 1.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 20,
              color: const Color.fromRGBO(224, 219, 236, 1.0),
              child: Image(image: NetworkImage(isWaiting ? '?' : image.toString(),),
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
                const SizedBox(height: 30,width: 20,),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
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
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        Text(
                          isWaiting ? '?' : 'Title: ${Rtitle.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          isWaiting
                              ? '?'
                              : 'Description: ${Rdescription.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          isWaiting
                              ? '?'
                              : 'Posted by: ${Rpostemail.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
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
                                  : 'Author: ${Rauthor.toString()}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          isWaiting
                              ? '?'
                              : 'Price: ${Rprice.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          isWaiting
                              ? '?'
                              : 'condition: ${Rcondition.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7,),
                      ],
                    ),),
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