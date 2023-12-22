// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:e_mart_fe/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String token = "2|N7xnYHRw2yZeJLiK99Wm3OzH0jpZmhS2rRPh3MyKf04b475f";
  Map _newList = {};
  Map get data => _newList;
  late final User user;

  getData() async {
    try {
      http.Response response = await http.get(
        Uri.parse("http://master-api.my.id/api/profile"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      setState(() {
        _newList = jsonDecode(response.body)['data'];
      });
    } catch (e) {
      print(e);
    }
  }

  updateData(context, String name, String email) async {
    http.Response response = await http.patch(
      Uri.parse("http://master-api.my.id/api/profile"),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "name": name,
        "email": email,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil update profile"),
          duration: Duration(milliseconds: 1000),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal update profile"),
          duration: Duration(milliseconds: 1000),
        ),
      );
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController auth = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 60,
                backgroundImage: NetworkImage(
                  "http://master-api.my.id/storage/images/profile/${data['picture']}",
                ),
              ),
              SizedBox(height: 80),
              TextField(
                controller: name..text = data['name'],
                decoration: InputDecoration(
                  label: Text("Name"),
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
                controller: email..text = data['email'],
                decoration: InputDecoration(
                  label: Text("Email"),
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
                controller: auth..text = data['auth'],
                readOnly: true,
                decoration: InputDecoration(
                  label: Text("User type"),
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
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  updateData(context, name.text, email.text);
                },
                child: Text("Update"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
