// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _ViewModelAuthButtonState { CanSumbit, AuthProgress, Disable }

class _ViewModelState {
  final String errorTitle;
  final String login;
  final String password;
  final _ViewModelAuthButtonState buttonState;

  _ViewModelState(
      {this.errorTitle = '',
      this.login = '',
      this.password = '',
      this.buttonState = _ViewModelAuthButtonState.CanSumbit});

  _ViewModelState copyWith({
    String? errorTitle,
    String? login,
    String? password,
    _ViewModelAuthButtonState? buttonState,
  }) {
    return _ViewModelState(
      errorTitle: errorTitle ?? this.errorTitle,
      login: login ?? this.login,
      password: password ?? this.password,
      buttonState: buttonState ?? this.buttonState,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void changeLogin(String value) {
    if (_state.login == value) return;
    _state = _state.copyWith(login: value);
    notifyListeners();
  }

  void changePassword(String value) {
    if (_state.password == value) return;
    _state = _state.copyWith(login: value);
    notifyListeners();
  }

  Future<void> onAuthButtonPrecess() async {
    final login = _state.login;
    final password = _state.password;
    if (login.isEmpty || password.isEmpty) return;

    try {
      await _authService.login(login, password);
    } on AuthApiProviderIsCorrectLoginDataProvider {
      _state = _state.copyWith(errorTitle: 'Неправильный логин или пароль');
    } catch (exeption) {
      _state = _state.copyWith(errorTitle: 'Не удалось понять ошибку');
    }
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
              ErrorText(),
              SizedBox(
                height: 20,
              ),
              FormAuthLogin(),
              SizedBox(
                height: 20,
              ),
              FormAuthPassword(),
              SizedBox(
                height: 20,
              ),
              AuthButton()
            ],
          ),
        ),
      )),
    );
  }
}

class FormAuthLogin extends StatelessWidget {
  const FormAuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextFormField(
      decoration: InputDecoration(
          label: Text('Логин'),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12))),
      onChanged: model.changeLogin,
    );
  }
}

class FormAuthPassword extends StatelessWidget {
  const FormAuthPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextFormField(
      decoration: InputDecoration(
          label: Text('Пароль'),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12))),
      onChanged: model.changePassword,
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    final authErrorText = context.select(
      (_ViewModel value) => value.state.errorTitle,
    );
    return Text(
      authErrorText,
      style: TextStyle(color: Colors.red),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    final buttonState =
        context.select((_ViewModel value) => value.state.buttonState);
    final onPressed = buttonState == _ViewModelAuthButtonState.CanSumbit
        ? model.onAuthButtonPrecess
        : null;
    final child = buttonState == _ViewModelAuthButtonState.AuthProgress
        ? const CircularProgressIndicator()
        : const Text('Авторизоваться');
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
