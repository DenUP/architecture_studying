import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_box)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.minimize_rounded)),
        ],
      ),
      body: const Center(
        child: Text(
          '0',
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
