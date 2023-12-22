// ignore_for_file: prefer_const_constructors

import 'package:e_mart_fe/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatelessWidget {
  const AddPage({super.key});
  static const routeName = '/add';
  final String token = "2|N7xnYHRw2yZeJLiK99Wm3OzH0jpZmhS2rRPh3MyKf04b475f";

  addData(context, String name, String stock, String desc, String price) async {
    http.Response response = await http.post(
      Uri.parse("http://master-api.my.id/api/product"),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "user_id": "eff5a1ed-491d-4a26-913b-f5fce3002b8c",
        "category_id": "9cbc9e68-8bdb-4c93-a235-8ed90c53ef83",
        "name": name,
        "stock": stock,
        "desc": desc,
        "price": price,
      },
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data berhasil ditambahkan"),
          duration: Duration(milliseconds: 800),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data gagal ditambahkan"),
          duration: Duration(milliseconds: 850),
        ),
      );
    }

    await Future.delayed(Duration(milliseconds: 800));
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController stock = TextEditingController();
    final TextEditingController price = TextEditingController();
    final TextEditingController desc = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Form Add Product",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 80),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  label: Text("Product Name"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: stock,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Stock"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: "Rp. ",
                  label: Text("Price"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: desc,
                decoration: InputDecoration(
                  label: Text("Description"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  addData(
                    context,
                    name.text,
                    stock.text,
                    desc.text,
                    price.text,
                  );
                },
                child: Text("Add data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
