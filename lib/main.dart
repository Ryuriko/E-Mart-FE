// ignore_for_file: prefer_const_constructors

import 'package:e_mart_fe/pages/add.dart';
import 'package:e_mart_fe/pages/auth/login.dart';
import 'package:e_mart_fe/pages/auth/register.dart';
import 'package:e_mart_fe/pages/detail_page.dart';
import 'package:e_mart_fe/pages/edit.dart';
import 'package:e_mart_fe/pages/home_page.dart';
import 'package:e_mart_fe/pages/profile/profile.dart';
// import 'package:e_mart_fe/pages/try.dart';
import 'package:e_mart_fe/pages/user/checkout.dart';
import 'package:e_mart_fe/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   textTheme: TextTheme(
        //     bodyMedium: TextStyle(
        //         // fontStyle: google
        //         ),
        //   ),
        // ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          RegsiterPage.routeName: (context) => RegsiterPage(),
          DetailPage.routeName: (context) => DetailPage(),
          AddPage.routeName: (context) => AddPage(),
          ProfilePage.routeName: (context) => ProfilePage(),
          CheckoutPage.routeName: (context) => CheckoutPage(),
          Edit.routeName: (context) => Edit(),
        },
        home: HomePage(),
      ),
    );
  }
}
