import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../Models/UpcommingBooksModel.dart';

class Upcommingbooks extends StatefulWidget {
  const Upcommingbooks({Key? key}) : super(key: key);

  @override
  State<Upcommingbooks> createState() => _UpcommingbooksState();
}

class _UpcommingbooksState extends State<Upcommingbooks> {
  String url = "http://10.0.2.2:8000/apis/v1/ubooks/";
  Future<List<UpcommingBooksModel>> _UpcommingBooksModel() async {
    Response response = await get(
      Uri.parse(url),
    );
    print(response.body);
    var productResponseData = jsonDecode(response.body);
    List<UpcommingBooksModel> bookDetails = [];
    for (var i in productResponseData) {
      UpcommingBooksModel Ubooks = UpcommingBooksModel(
        name: i['name'],
        image: i['image'],
        author: i['author'],
      );

      bookDetails.add(Ubooks);
    }
    print(bookDetails);

    return bookDetails;
  }

  @override
  void initState() {
    _UpcommingBooksModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(
            child: Text('Upcomming Books'),
          ),
        ),
        body: FutureBuilder(
            future: _UpcommingBooksModel(),
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
                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shadowColor:
                                    const Color.fromRGBO(133, 13, 189, 1.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                elevation: 10,
                                color: const Color.fromRGBO(238, 214, 255, 1.0),
                                child: SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Image.network(
                                              '${snapshot.data[index].image}',
                                              height: 150,
                                              width: 150,
                                              //fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Name: ${snapshot.data[index].name}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Author: ${snapshot.data[index].author}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );

                    return const Padding(
                      padding: EdgeInsets.all(3.0),
                    );
                  },
                );
              }
            }),
        // ],
      ),
    );
  }
}
