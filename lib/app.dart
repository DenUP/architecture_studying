import 'package:architecture_studying/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '',
      routes: {'/': (context) => const Home()},
    );
  }
}
