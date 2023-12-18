import 'package:e_mart_fe/pages/add.dart';
import 'package:e_mart_fe/pages/detail_page.dart';
import 'package:e_mart_fe/pages/home_page.dart';
import 'package:e_mart_fe/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        DetailPage.routeName: (context) => DetailPage(),
        AddPage.routeName: (context) => AddPage(),
      },
      home: ChangeNotifierProvider(
        create: (context) {
          return HttpProvider();
        },
        child: HomePage(),
      ),
    );
  }
}
