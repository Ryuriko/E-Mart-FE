// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});
  static const routeName = '/checkout';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int qty = 1;
  String token = "2|N7xnYHRw2yZeJLiK99Wm3OzH0jpZmhS2rRPh3MyKf04b475f";

  counter_add() {
    setState(() {
      qty++;
    });
  }

  counter_min() {
    if (qty > 1) {
      setState(() {
        qty--;
      });
    }
  }

  transaction(context, dynamic userId, dynamic product_name, int qty) async {
    print(qty);
    http.Response response = await http.post(
      Uri.parse(
        "http://master-api.my.id/api/transaction",
      ),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "user_id": userId,
        "product": product_name,
        "qty": qty,
      },
    );
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil melakukan transaksi"),
          duration: const Duration(milliseconds: 800),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal Melakukan transaksi"),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
    await Future.delayed(Duration(milliseconds: 850));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image(
                  image: NetworkImage(
                    "https://picsum.photos/id/${arguments['index']}/200",
                    scale: 1.4,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      arguments['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 180,
                      child: Text(
                        arguments['desc'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Rp. ${arguments['price']}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Quantity : $qty",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15),
                IconButton(
                  onPressed: () {
                    counter_min();
                  },
                  icon: Icon(
                    Icons.remove_circle_rounded,
                  ),
                ),
                SizedBox(width: 0),
                IconButton(
                  onPressed: () {
                    counter_add();
                  },
                  icon: Icon(
                    Icons.add_circle_rounded,
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // print(arguments);
                  transaction(
                    context,
                    arguments['userId'].toString(),
                    arguments['name'].toString(),
                    qty,
                  );
                },
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
