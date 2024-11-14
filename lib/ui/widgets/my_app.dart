import 'package:architecture_studying/ui/widgets/example_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ExampleWidget(),
      },
    );
  }
}
