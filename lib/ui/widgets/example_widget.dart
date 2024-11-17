import 'package:architecture_studying/domain/bloc/userbloc.dart';
import 'package:architecture_studying/domain/bloc/usercubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
    final bloc = context.read<Usercubit>();
    return StreamBuilder(
      initialData: bloc.state,
      stream: bloc.stream,
      builder: (context, snapshot) {
        final age = snapshot.requireData.userCurrent.age;
        return Text('$age');
      },
    );
  }
}

class _IncrementAge extends StatelessWidget {
  const _IncrementAge({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Usercubit>();
    return ElevatedButton(onPressed: bloc.increment, child: Text('+'));
  }
}

class _DecrementAge extends StatelessWidget {
  const _DecrementAge({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Usercubit>();
    return ElevatedButton(onPressed: bloc.decrement, child: Text('-'));
  }
}
