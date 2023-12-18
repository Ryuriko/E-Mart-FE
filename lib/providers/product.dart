import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpProvider with ChangeNotifier {
  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  int get jumlahData {
    return _data.length;
  }

  void get(context, String? nama) async {
    Uri url = this.url('/api/users?page=2');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      _data = jsonDecode(response.body);
      notifyListeners();
      handlingResponse(context, "BERHASIL MENDAPATKAN DATA");
    } else {
      handlingResponse(context, "GAGAL MENDAPATKAN DATA");
    }
  }

  void post(context, String name, String job) async {
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

  void patch(context, String name, String job, String id) async {
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

  void delete(context, String id) async {
    Uri url = this.url('/api/user/$id');
    var response = await http.delete(url);

    if (response.statusCode == 204) {
      _data = {};
      notifyListeners();
      handlingResponse(context, "BERHASIL MENGHAPUS DATA");
    } else {
      handlingResponse(context, "GAGAL MENGHAPUS DATA");
    }
  }

  Uri url(String request) {
    Uri requestParse = Uri.parse(request);
    Uri url = Uri.parse('https://reqres.in$requestParse');
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
