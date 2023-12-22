// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_mart_fe/pages/edit.dart';
import 'package:e_mart_fe/pages/home_page.dart';
import 'package:e_mart_fe/pages/user/checkout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});
  static const routeName = '/detail';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String token = "2|N7xnYHRw2yZeJLiK99Wm3OzH0jpZmhS2rRPh3MyKf04b475f";

  delete(context, String id) async {
    http.Response response = await http.delete(
      Uri.parse("http://master-api.my.id/api/product/$id"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil menghapus data"),
          duration: Duration(milliseconds: 1000),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menghapus data"),
          duration: Duration(milliseconds: 1000),
        ),
      );
    }
    await Future.delayed(Duration(milliseconds: 1500));
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text("Hapus data"),
                    content: Text("Apa anda yakin?"),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("No"),
                      ),
                      FilledButton(
                        onPressed: () {
                          delete(context, arguments['id']);
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
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
