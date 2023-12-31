// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:e_mart_fe/pages/auth/register.dart';
import 'package:e_mart_fe/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2021/11/01/13/17/login-6760338_1280.png'),
                  width: 100,
                ),
                SizedBox(height: 50),
                TextField(
                  controller: email,
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
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Password"),
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
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        login(context, email.text, password.text);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegsiterPage.routeName);
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

login(context, String email, String password) async {
  http.Response response = await http.post(
    Uri.parse('http://master-api.my.id/api/login'),
    body: {
      'email': email,
      'password': password,
    },
  );

  Map data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Berhasil Login'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  HomePage.routeName,
                  arguments: {
                    'token': data['personal_token'],
                  },
                );
              },
              child: Text('oke'),
            ),
          ],
        );
      },
    );
    print('oke');
  } else {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Credential tidak ditemukan'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
              },
              child: Text('oke'),
            ),
          ],
        );
      },
    );
    print('gagal');
  }
}
