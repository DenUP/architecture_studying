import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/data_provider/user_data_provider.dart';
import '../domain/services/user_servise.dart';

class VieWModelState {
  final String ageTitle;

  VieWModelState({required this.ageTitle});
}

class ViewModel extends ChangeNotifier {
  final _userServise = UserServise();
  final userDataProvider = UserDataProvider();
  var _state = VieWModelState(ageTitle: '');

  VieWModelState get state => _state;

  ViewModel() {
    loadValue();
  }

  Future<void> loadValue() async {
    await _userServise.initialize();
    _updateState();
    // final sharedPreferences = await SharedPreferences.getInstance();
    // _age = sharedPreferences.getInt('age') ?? 0;
    // notifyListeners();
  }

  void onIncrementButtonPressed() {
    _userServise.increment();
    _updateState();
  }

  void onDecrementButtonPressed() {
    _userServise.decrement();
    _updateState();
    // _age = max(_age - 1, 0);
    // final sharedPreferences = await SharedPreferences.getInstance();
    // await sharedPreferences.setInt('age', _age);
    // notifyListeners();
  }

  void _updateState() {
    final user = _userServise.user;
    _state = VieWModelState(ageTitle: user.age.toString());
    notifyListeners();
  }
}

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
              _AgeIncrementWidget(),
              _AgeDecrementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.select((ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: model.onIncrementButtonPressed,
      child: const Text('+'),
    );
  }
}

class _AgeDecrementWidget extends StatelessWidget {
  const _AgeDecrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: model.onDecrementButtonPressed,
      child: const Text('-'),
    );
  }
}
