import 'package:architecture_studying/example/example_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ChangeNotifierProvider.value(
            value: ViewModel(), child: const ExampleWidget()),
      },
    );
  }
}
