import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bookbinnepal/present/screens/Message/Message.dart';
import 'package:bookbinnepal/present/screens/Notification/Notifications.dart';
import 'package:bookbinnepal/present/screens/profile/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  File? image;
  Uint8List? imageValue;
  String? imageName;
  final auth = FirebaseAuth.instance;
  String url = "http://10.0.2.2:8000/apis/v1/";

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    PlatformFile? file1 = result?.files.first;
    //allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']
    if (result != null) {
      Uint8List? file = file1?.bytes;
      String sc = result.files.single.name;
      setState(() {
        print(file);
        print(sc);
        imageName = sc;
        imageValue = file;
      });
    } else {
      print('file not choose');
    }
  }

  addProduct() async {
    var postUri = Uri.parse(url);
    var request = MultipartRequest("POST", postUri);
    String userId = auth.currentUser!.uid;
    String? userEmail = auth.currentUser!.email;
    request.fields['title'] = AddProduct.title.text;
    request.fields['description'] = AddProduct.description.text;
    // request.fields['negotiable'] = AddProduct.n;
    request.files.add(
      MultipartFile.fromBytes('image', imageValue!, filename: imageName),
    );

    var response = await request.send();
    print(response.stream);
    print(response.statusCode);

    // if (){
    //   const snackBar = SnackBar(content: Text('Product has been successfully added.'));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    if (response.statusCode == 201) {
      const snackBar =
          SnackBar(content: Text('Product has been successfully added.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // User canceled the picker

  // addProduct() async {
  //   String title = AddProduct.title.value.text;
  //   String description = AddProduct.description.value.text;
  //
  //   ProductModel postProduct = ProductModel(
  //     title: title,
  //     description: description,
  //   );
  //
  //   var response = await post(Uri.parse(url),
  //       body: json.encode(postProduct),
  //       headers: {'Content-Type': 'application/json'});
  //   print(response.statusCode);
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(child: Text('Add Products')),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: AddProduct.title,
                  decoration: const InputDecoration(hintText: 'Title'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: AddProduct.description,
                  decoration: const InputDecoration(hintText: 'Description'),
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {
                    uploadImage();
                  },
                  child: const Text('Select Image'),
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
                        const Color.fromRGBO(174, 140, 199, 1.0),
                      ),
                    ),
                    onPressed: () {
                      addProduct();
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) =>
                      //       _buildPopupDialog(context),
                      // );
                    },
                    child: const Text("Submit")),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chats()),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        ),
      ),
    );
  }
}

//
// Widget _buildPopupDialog(BuildContext context) {
//   return AlertDialog(
//     title: const Text(''),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Center(child: Text("Added Sucessfully!")),
//       ],
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => AddProduct()),
//           // );
//         },
//         child: const Text('Close'),
//       ),
//     ],
//   );
// }
