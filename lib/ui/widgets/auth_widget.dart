import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/domain/services/auth_servise.dart';

enum _ViewModelAuthButtonState { CanSubmit, AuthProcess, Disable }

class _ViewModelState {
  final String authErrorTitle;
  final String login;
  final String password;
  final _ViewModelAuthButtonState stateButton;

  _ViewModelState(
      {this.authErrorTitle = '',
      this.login = '',
      this.password = '',
      this.stateButton = _ViewModelAuthButtonState.Disable});

  _ViewModelState copyWith({
    String? authErrorTitle,
    String? login,
    String? password,
    _ViewModelAuthButtonState? stateButton,
  }) {
    return _ViewModelState(
      authErrorTitle: authErrorTitle ?? this.authErrorTitle,
      login: login ?? this.login,
      password: password ?? this.password,
      stateButton: stateButton ?? this.stateButton,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  final _authServise = AuthServise();
  _ViewModelState get state => _state;

  void changeLogin(String value) {
    if (state.login == value) return;
    _state.copyWith(login: value);
    notifyListeners();
  }

  void changePassword(String value) {
    if (state.password == value) return;
    _state.copyWith(password: value);
    notifyListeners();
  }

  Future<void> onAuthButtonPressed() async {
    final login = _state.login;
    final password = _state.password;
    if (login.isEmpty || password.isEmpty) return;

    try {
      await _authServise.login(login, password);
    } on AuthProviderIncorectLoginDataError {
      _state = _state.copyWith(authErrorTitle: 'Неправильный логин или пароль');
    } catch (exeption) {
      _state = _state.copyWith(
          authErrorTitle: 'Неизвестная ошибка, повторите позже');
    }
    notifyListeners();
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
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _ErrorTextWidget(),
              _LoginWidget(),
              _PasswordWidget(),
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
    return ElevatedButton(
        onPressed: model.onAuthButtonPressed,
        child: const Text(
          'Войти',
          style: TextStyle(color: Colors.green),
        ));
  }
}
