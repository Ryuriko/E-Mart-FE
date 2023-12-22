// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_mart_fe/pages/edit.dart';
import 'package:e_mart_fe/pages/user/checkout.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)?.settings.arguments;
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("E - Mart"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Edit.routeName, arguments: {
                "index": arguments['index'],
                "token": arguments['token'],
                "id": arguments['id'],
                "name": arguments['name'],
                "price": arguments['price'],
                "stock": arguments['stock'],
                "desc": arguments['desc'],
                "userId": arguments['userId'],
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  (arguments['picture'] == null)
                      ? "https://picsum.photos/id/${arguments['index']}/200"
                      : "http://master-api/api/product/${arguments['picture']}",
                  scale: 0.5,
                ),
                height: 350,
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      arguments['name'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      arguments['desc'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Rp. ${arguments['price']} ,-",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.bottomRight,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                CheckoutPage.routeName,
                                arguments: {
                                  "index": arguments['index'],
                                  "token": arguments['token'],
                                  "name": arguments['name'],
                                  "stock": arguments['stock'],
                                  "price": arguments['price'],
                                  "desc": arguments['desc'],
                                  "userId": arguments['userId'],
                                },
                              );
                            },
                            child: Text("Checkout"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
