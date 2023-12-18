// ignore_for_file: avoid_print

import 'package:e_mart_fe/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HttpProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Mart"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                provider.get(context, "get");
                print(provider.data);
              },
              child: const Text("Get Data"),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                provider.post(context, "morpheus", "leader");
                print(provider.data);
              },
              child: const Text("Post Data"),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                provider.patch(
                    context, "morpheus update", "leader update", '2');
                print(provider.data);
              },
              child: const Text("Patch Data"),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                provider.delete(context, '2');
                print(provider.data);
              },
              child: const Text("Delete Data"),
            ),
          ],
        ),
      ),
    );
  }
}
