import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData(String file) async {
  final String base = 'https://lkctc-app.herokuapp.com';
  final String url = '$base$file';
  print(url);
  try {
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  } catch (e) {
    debugPrint("Didn't get data\nError: $e");
    return {'data': "No data"};
  }
}
