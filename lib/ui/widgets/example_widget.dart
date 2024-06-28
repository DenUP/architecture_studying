import 'package:architecture_studying/domain/services/auth_servise.dart';
import 'package:architecture_studying/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/data_provider/user_data_provider.dart';
import '../../domain/services/user_servise.dart';

class _VieWModelState {
  final String ageTitle;

  _VieWModelState({required this.ageTitle});
}

class _ViewModel extends ChangeNotifier {
  final _authServise = AuthServise();
  final _userServise = UserServise();
  final userDataProvider = UserDataProvider();
  var _state = _VieWModelState(ageTitle: '');

  _VieWModelState get state => _state;

  _ViewModel() {
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

  Future<void> onLogoutPressed(BuildContext context) async {
    await _authServise.logout();
    MainNavigation.showLoader(context);
  }

  void _updateState() {
    final user = _userServise.user;
    _state = _VieWModelState(
      ageTitle: user.age.toString(),
    );
    notifyListeners();
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider.value(
        value: _ViewModel(), child: const ExampleWidget());
  }

  @override
  Widget build(BuildContext context) {
    // final model = context.read<_ViewModel>()._sessionDataProvider.clearApiKey;
    final model = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => model.onLogoutPressed(context),
            child: const Text('Выход'),
          )
        ],
      ),
      body: const SafeArea(
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
    final title = context.select((_ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
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
    final model = context.read<_ViewModel>();
    return ElevatedButton(
      onPressed: model.onDecrementButtonPressed,
      child: const Text('-'),
    );
  }
}
