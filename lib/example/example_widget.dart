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
  Future<void> onLoading() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await get(url);
    final json = jsonDecode(response.body) as List<dynamic>;
    _posts += json;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider(state: this, child: const _View());
  }
}

class _View extends StatelessWidget {
  const _View({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.dependOnInheritedWidgetOfExactType<Provider>()!.state;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: state.onLoading, child: const Text('Loading post')),
          Expanded(
              child: ListView.builder(
            itemCount: state._posts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(state._posts[index]['title']),
                    Text(state._posts[index]['id'].toString())
                  ],
                ),
              );
            },
          ))
        ],
      )),
    );
  }
}

class Provider extends InheritedWidget {
  final _ExampleWidgetState state;
  const Provider({
    required this.state,
    required super.child,
  });

  static Provider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }

  static Provider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<Provider>()?.widget;
    return widget is Provider ? widget : null;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return child != oldWidget.child;
  }
}
