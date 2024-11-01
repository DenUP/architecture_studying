import 'package:architecture_studying/ui/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '',
      routes: {'/': (context) => AuthWidget.create()},
    );
  }
}
