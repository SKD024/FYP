import 'dart:io';
import 'dart:typed_data';
import 'package:bookbinnepal/present/screens/MyBooks.dart';
import 'package:bookbinnepal/present/screens/UpcoommingBooks/upcommingbooks.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static String id = "addproduct_page";
  static var title = TextEditingController();
  static var description = TextEditingController();
  static var genre = TextEditingController();
  static var author = TextEditingController();
  static var price = TextEditingController();

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String dropdownValue = 'New';
  File? image;
  Uint8List? imageValue;
  String? imageName;
  final auth = FirebaseAuth.instance;
  String url = "http://10.0.2.2:8000/apis/v1/";
  bool pickedimage = false;
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
        pickedimage = true;
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
    // String userID = auth.currentUser!.uid;
    //String? postemail = auth.currentUser!.email;
    request.fields['title'] = AddProduct.title.text;
    request.fields['userID'] = auth.currentUser!.uid;
    request.fields['postemail'] = auth.currentUser!.email!;
    request.fields['description'] = AddProduct.description.text;
    request.fields['genre'] = AddProduct.genre.text;
    request.fields['author'] = AddProduct.author.text;
    request.fields['price'] = AddProduct.price.text;
    request.fields['condition'] = dropdownValue;
    request.files.add(
      MultipartFile.fromBytes('image', imageValue!, filename: imageName),
    );

    var response = await request.send();
    print(response.stream);
    print(response.statusCode);
    if (response.statusCode == 201) {
      const snackBar =
          SnackBar(content: Text('Book has been added successfully.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(child: Text('Add Books')),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: AddProduct.title,
                  decoration: const InputDecoration(hintText: 'Title'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: AddProduct.description,
                  decoration: const InputDecoration(hintText: 'Description'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: AddProduct.genre,
                  decoration: const InputDecoration(hintText: 'Genre'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: AddProduct.author,
                  decoration: const InputDecoration(hintText: 'Author'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: AddProduct.price,
                  decoration: const InputDecoration(hintText: 'Price'),
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        uploadImage();
                      },
                      child: const Text('Select Image'),
                    ),
                    Text(pickedimage
                        ? imageName.toString()
                        : 'No image Picked!'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Condition:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                        height: 2, color: const Color.fromRGBO(174, 140, 199, 1.0)),
                    isExpanded: false,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'New',
                      'Used',
                      'LikeNew',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 20),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                    },
                    child: const Text("Submit")),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const Upcommingbooks(),
            //   ),
            // );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        ),
      ),
    );
  }
}
