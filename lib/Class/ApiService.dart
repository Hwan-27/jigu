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

    //헤더 추가
    dio.options.headers['getHeader'] = 'getValue';

    final response =
        //await dio.get('https://jsonplaceholder.typicode.com/posts');
        await dio.get('http://localhost:4000/api/getitems');
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

  Future<void> postData(Map<String, dynamic> data) async {
    final dio = Dio();
    final response =
        await dio.post('http://localhost:4000/apiPostitems', data: data);

    if (response.statusCode == 200) {
      print('데이터가 전송되었습니다.');
    } else {
      print('데이터 전송에 실패하였습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
