import 'package:architecture_studying/ui/widgets/auth_widget.dart';
import 'package:architecture_studying/ui/widgets/example_widget.dart';
import 'package:architecture_studying/ui/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '',
      routes: {
        '/': (context) => LoaderWidget.create(),
        '/auth': (context) => AuthWidget.create(),
        '/example': (context) => ExampleWidget.create()
      },
    );
  }
}
