// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:e_mart_fe/models/product.dart';
import 'package:e_mart_fe/pages/add.dart';
import 'package:e_mart_fe/pages/detail_page.dart';
import 'package:e_mart_fe/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> _newsList = [];
  late final Data data;
  String token = "2|N7xnYHRw2yZeJLiK99Wm3OzH0jpZmhS2rRPh3MyKf04b475f";

  void getData() async {
    http.Response response = await http
        .get(Uri.parse("http://master-api.my.id/api/product"), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
    setState(() {
      _newsList = Product.fromJson(jsonDecode(response.body)).data;
      // print(_newsList[0].name);
    });
  }

  @override
  void initState() {
    getData();
    // print(_newsList);?
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Mart"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPage.routeName);
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProfilePage.routeName);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 23,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Text(
                  "Welcome, Yohan store",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Your product",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: _newsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return MaterialButton(
                    onPressed: () {
                      // print(_newsList[index].userId);
                      Navigator.of(context).pushNamed(
                        DetailPage.routeName,
                        arguments: {
                          "index": index,
                          "token": token,
                          "id": _newsList[index].id,
                          "name": _newsList[index].name,
                          "price": _newsList[index].price,
                          "stock": _newsList[index].stock,
                          "desc": _newsList[index].desc,
                          "userId": _newsList[index].userId,
                        },
                      );
                    },
                    child: GridTile(
                      footer: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.grey.withOpacity(0.8),
                        child: Center(
                          child: Text(
                            _newsList[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      child: Image(
                        image: NetworkImage(
                            "https://picsum.photos/id/$index/200/215"
                            // : "http://master-api/storage/product/${product.data[index].picture}/200",
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
