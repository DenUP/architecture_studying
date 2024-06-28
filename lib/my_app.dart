import 'package:architecture_studying/ui/widgets/auth_widget.dart';
import 'package:architecture_studying/ui/widgets/example_widget.dart';
import 'package:architecture_studying/ui/widgets/loader_widget.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == '/example') {
          return PageRouteBuilder(
              settings:
                  settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
              pageBuilder: (_, __, ___) => ExampleWidget.create(),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c));
        } else if (settings.name == '/auth') {
          return PageRouteBuilder(
              settings:
                  settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
              pageBuilder: (_, __, ___) => AuthWidget.create(),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c));
        } else if (settings.name == '/') {
          return PageRouteBuilder(
              settings:
                  settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
              pageBuilder: (_, __, ___) => LoaderWidget.create(),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c));
        }
      },
    );
  }
}
