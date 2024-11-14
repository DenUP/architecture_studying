import 'package:architecture_studying/domain/bloc/userbloc.dart';
import 'package:architecture_studying/ui/widgets/example_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Provider(
              create: (context) => Userbloc(),
              child: const ExampleWidget(),
            ),
      },
    );
  }
}
