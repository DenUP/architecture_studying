import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  var _posts = <dynamic>[];
  Future<void> _onLoading() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await get(url);
    final json = jsonDecode(response.body) as List<dynamic>;
    _posts += json;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: _onLoading, child: const Text('Loading post')),
          Expanded(
              child: ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(_posts[index]['title']),
                  Text(_posts[index]['id'].toString())
                ],
              );
            },
          ))
        ],
      )),
    );
  }
}
