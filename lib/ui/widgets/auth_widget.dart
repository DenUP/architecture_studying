import 'package:architecture_studying/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/domain/services/auth_servise.dart';

enum _ViewModelAuthButtonState { canSubmit, authProcess, disable }

class _ViewModelState {
  String authErrorTitle = '';
  String login = '';
  String password = '';
  bool isAuthInProcess = false;
  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcess;
    } else if (login.trim().isNotEmpty && password.trim().isNotEmpty) {
      return _ViewModelAuthButtonState.canSubmit;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }

  _ViewModelState();
}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  final _authServise = AuthServise();
  _ViewModelState get state => _state;

  void changeLogin(String value) {
    if (state.login == value) return;
    _state.login = value;
    notifyListeners();
  }

  void changePassword(String value) {
    if (state.password == value) return;
    _state.password = value;
    notifyListeners();
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    final login = _state.login;
    final password = _state.password;
    if (login.isEmpty || password.isEmpty) return;
    _state.authErrorTitle = '';
    _state.isAuthInProcess = true;
    notifyListeners();

    try {
      await _authServise.login(login, password);
      _state.isAuthInProcess = false;
      MainNavigation.showLoader(context);
      notifyListeners();
    } on AuthProviderIncorectLoginDataError {
      _state.authErrorTitle = 'Неправильный логин или пароль';
      _state.isAuthInProcess = false;
      notifyListeners();
    } catch (exeption) {
      _state.authErrorTitle = 'Неизвестная ошибка, повторите позже';
      _state.isAuthInProcess = false;
      notifyListeners();
    }
    // notifyListeners();
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const AuthWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ErrorTextWidget(),
              SizedBox(
                height: 10,
              ),
              _LoginWidget(),
              SizedBox(
                height: 10,
              ),
              _PasswordWidget(),
              SizedBox(
                height: 10,
              ),
              _AuthButtonWidget(),
            ],
          ),
        ),
      )),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  const _LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Логин',
      ),
      onChanged: model.changeLogin,
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Пароль',
      ),
      onChanged: model.changePassword,
    );
  }
}

class _ErrorTextWidget extends StatelessWidget {
  const _ErrorTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authErrorTitle =
        context.select((_ViewModel value) => value.state.authErrorTitle);
    return Text(authErrorTitle);
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    final authButtonState = context.select(
      (_ViewModel vm) => vm.state.authButtonState,
    );
    final onPressed = authButtonState == _ViewModelAuthButtonState.canSubmit
        ? model.onAuthButtonPressed
        : null;
    final child = authButtonState == _ViewModelAuthButtonState.authProcess
        ? const CircularProgressIndicator()
        : const Text('Войти');
    return ElevatedButton(
      onPressed: () => onPressed?.call(context),
      child: child,
    );
  }
}
