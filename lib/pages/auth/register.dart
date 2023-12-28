// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:e_mart_fe/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegsiterPage extends StatelessWidget {
  const RegsiterPage({super.key});
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController passwordConfirmation = TextEditingController();

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
                      'https://cdn.pixabay.com/photo/2016/08/29/09/22/register-1627729_1280.png'),
                  width: 200,
                ),
                SizedBox(height: 0),
                TextField(
                  controller: name,
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
                TextField(
                  controller: passwordConfirmation,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Password Confirmation"),
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
                        register(
                          context,
                          name.text,
                          email.text,
                          password.text,
                          passwordConfirmation.text,
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginPage.routeName);
                      },
                      child: Text('Login'),
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

register(context, String name, String email, String password,
    String passwordConfirmation) async {
  http.Response response = await http.post(
    Uri.parse('http://master-api.my.id/api/register'),
    body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    },
  );

  if (response.statusCode == 201) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Berhasil mendaftar, silahkan lanjutkan login'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  LoginPage.routeName,
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
    print(response.body);
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Gagal mendaftar, periksa kembali data anda'),
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
