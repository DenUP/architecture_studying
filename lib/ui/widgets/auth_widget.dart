// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum _ViewModelStateButton { canSumbit, isProcess, disable }

class _ViewModelState {
  final String errorText;
  final String login;
  final String password;
  final bool isProcess;
  _ViewModelStateButton get buttonState {
    if (isProcess == true) {
      return _ViewModelStateButton.isProcess;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return _ViewModelStateButton.canSumbit;
    } else {
      return _ViewModelStateButton.disable;
    }
  }

  _ViewModelState({
    this.errorText = '',
    this.login = '',
    this.password = '',
    this.isProcess = false,
  });

  _ViewModelState copyWith({
    String? errorText,
    String? login,
    String? password,
    bool? isProcess,
  }) {
    return _ViewModelState(
      errorText: errorText ?? this.errorText,
      login: login ?? this.login,
      password: password ?? this.password,
      isProcess: isProcess ?? this.isProcess,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  Future<void> changeLogin(String value) async {
    if (_state.login == value) return;
    _state = _state.copyWith(login: value);
    notifyListeners();
  }

  Future<void> changePassword(String value) async {
    if (_state.password == value) return;
    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  Future<void> onClickButton() async {
    final login = _state.login;
    final password = _state.password;
    if (login.isEmpty || password.isEmpty) return;
    _state = _state.copyWith(errorText: '', isProcess: true);
    try {
      await _authService.login(login, password);
      _state = _state.copyWith(errorText: '', isProcess: false);
    } on AuthErrorApiDataProvider {
      _state = _state.copyWith(errorText: 'Ошибка данных', isProcess: false);
    } catch (exeption) {
      _state = _state.copyWith(errorText: 'Другая ошибочка', isProcess: false);
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
            children: [
              errorText(),
              authFormLogin(),
              SizedBox(
                height: 20,
              ),
              authFormPassword(),
              onClickAuthButton()
            ],
          ),
        ),
      )),
    );
  }
}

class errorText extends StatelessWidget {
  const errorText({super.key});

  @override
  Widget build(BuildContext context) {
    final errorText =
        context.select((_ViewModel value) => value._state.errorText);
    return Text(errorText);
  }
}

class authFormLogin extends StatelessWidget {
  const authFormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextFormField(
      decoration: const InputDecoration(
          label: Text('Логин'),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)))),
      onChanged: model.changeLogin,
    );
  }
}

class authFormPassword extends StatelessWidget {
  const authFormPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextFormField(
      onChanged: model.changePassword,
      decoration: const InputDecoration(
          label: Text('Пароль'),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)))),
    );
  }
}

class onClickAuthButton extends StatelessWidget {
  const onClickAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    final buttonState =
        context.select((_ViewModel value) => value._state.buttonState);
    final onPressed = buttonState == _ViewModelStateButton.canSumbit
        ? model.onClickButton
        : null;
    final child = buttonState == _ViewModelStateButton.isProcess
        ? const CircularProgressIndicator()
        : const Text('Авторизоваться');
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
