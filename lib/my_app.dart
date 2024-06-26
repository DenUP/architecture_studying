import 'package:architecture_studying/domain/data_provider/user_data_provider.dart';
import 'package:architecture_studying/ui/widgets/auth_widget.dart';
import 'package:architecture_studying/ui/widgets/example_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ExampleWidget.create(),
        '/auth': (context) => AuthWidget.create(),
      },
    );
  }
}
