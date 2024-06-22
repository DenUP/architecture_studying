import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  var _age = 0;

  int get age => _age;

  ViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _age = sharedPreferences.getInt('age') ?? 0;
    notifyListeners();
  }

  Future<void> increment() async {
    _age += 1;
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('age', _age);
    notifyListeners();
  }

  Future<void> decrement() async {
    _age = max(_age - 1, 0);
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('age', _age);
    notifyListeners();
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${model._age}"),
              ElevatedButton(
                onPressed: () async {
                  model.increment();
                },
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () async {
                  model.decrement();
                },
                child: const Text('-'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
