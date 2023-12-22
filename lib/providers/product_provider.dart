import 'dart:convert';

import 'package:e_mart_fe/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Data> _data = [];
  List<Data> get data => _data;

  String token = "2|N7xnYHRw2yZeJLiK99Wm3OzH0jpZmhS2rRPh3MyKf04b475f";

  int get jumlahData {
    return data.length;
  }

  get(String? nama) async {
    Uri url = this.url('/product');
    // Uri url = this.url('/api/users?page=2');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    _data = Product.fromJson(jsonDecode(response.body)).data;
    notifyListeners();
  }

  post(context, String name, String job) async {
    Uri url = this.url('/api/users');
    var response = await http.post(url, body: {
      "name": name,
      "job": job,
    });

    if (response.statusCode == 201) {
      _data = jsonDecode(response.body);
      notifyListeners();
      handlingResponse(context, "BERHASIL MENDAPATKAN DATA");
    } else {
      handlingResponse(context, "GAGAL MENDAPATKAN DATA");
    }
  }

  patch(context, String name, String job, String id) async {
    Uri url = this.url('/api/user/$id');
    var response = await http.patch(url, body: {
      "name": name,
      "job": job,
    });

    if (response.statusCode == 200) {
      _data = jsonDecode(response.body);
      notifyListeners();
      handlingResponse(context, "BERHASIL MENDAPATKAN DATA");
    } else {
      handlingResponse(context, "GAGAL MENDAPATKAN DATA");
    }
  }

  delete(context, String id) async {
    Uri url = this.url('/api/user/$id');
    var response = await http.delete(url);

    if (response.statusCode == 204) {
      // _data = {};
      notifyListeners();
      handlingResponse(context, "BERHASIL MENGHAPUS DATA");
    } else {
      handlingResponse(context, "GAGAL MENGHAPUS DATA");
    }
  }

  Uri url(String request) {
    Uri requestParse = Uri.parse(request);
    Uri url = Uri.parse('http://master-api.my.id/api$requestParse');
    // Uri url = Uri.parse('https://reqres.in$requestParse');
    return url;
  }

  handlingResponse(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Product with ChangeNotifier {
//   Map<String, dynamic> _items = {};
//   Map<String, dynamic> get items => _items;

//   get(String id) async {
//     Uri url = Uri.parse("https://reqres.in/api/users/$id");

//     var hasilResponse = await http.get(url);

//     _items = jsonDecode(hasilResponse.body)["data"];
//     notifyListeners();
//   }
// }
