import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            _AgeTitle(),
            _IncrementAge(),
            _DecrementAge(),
          ],
        ),
      )),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('0');
  }
}

class _IncrementAge extends StatelessWidget {
  const _IncrementAge({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text('+'));
  }
}

class _DecrementAge extends StatelessWidget {
  const _DecrementAge({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text('-'));
  }
}
