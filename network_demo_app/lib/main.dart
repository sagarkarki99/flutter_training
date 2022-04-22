import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _saveRemoteData();
          },
          child: Text("Get Data"),
        ),
      ),
    );
  }

  Future<void> _getRemoteData(int id) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );
    Map<String, dynamic> readableResponse = jsonDecode(response.body);

    print(readableResponse);
  }

  Future<void> _saveRemoteData() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode({
        'userId': '1',
        'title': 'THis is second post method test.',
        'body': 'This is body of second post method test.'
      }),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );
    Map<String, dynamic> readableResponse = jsonDecode(response.body);

    print(readableResponse);
  }
}

class Movie {}
