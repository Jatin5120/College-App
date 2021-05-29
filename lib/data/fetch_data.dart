import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> fetchData(String file) async {
  // http.Response response = await http.get(Uri.parse(url));
  try {
    debugPrint("Reading - assets/api$file.json");
    String jsonResult = await rootBundle.loadString("assets/api$file.json");
    Map<String, dynamic> data = json.decode(jsonResult);
    return data;
  } catch (e) {
    debugPrint("Didn't get data\nError: $e");
    return {'data': "No data"};
  }
}
