import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => Api_Service();
}

class Api_Service extends State<ApiPage> {
  Future<List<Map<String, dynamic>>?> getData() async {
    final dio = Dio();
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;

      final List<Map<String, dynamic>> data =
          jsonData.map((item) => item as Map<String, dynamic>).toList();
      print('데이터를 가져옴');
      return data;
    } else {
      throw Exception('Failed to load data');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
