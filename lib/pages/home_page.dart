// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_mart_fe/pages/add.dart';
import 'package:e_mart_fe/pages/detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/home';

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
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 20,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                SizedBox(width: 8),
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
                itemCount: 26,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        DetailPage.routeName,
                        arguments: {'index': index},
                      );
                    },
                    child: GridTile(
                      footer: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.grey.withOpacity(0.8),
                        child: Column(
                          children: [
                            Text(
                              "Nama",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "RP. 10000",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      child: Image(
                        image:
                            NetworkImage("https://picsum.photos/id/$index/200"),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Expanded(
            //   child: GridView(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 20,
            //       mainAxisSpacing: 20,
            //     ),
            //     scrollDirection: Axis.vertical,
            //     children: myContainer,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
