// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _ViewModelAuthButtonState { canSumbit, authProgress, disable }

class _ViewModelState {
  final String errorTitle;
  final String login;
  final String password;
  final bool isAuthInProcess;
  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProgress;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return _ViewModelAuthButtonState.canSumbit;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }

  _ViewModelState({
    this.errorTitle = '',
    this.login = '',
    this.password = '',
    this.isAuthInProcess = false,
  });

  _ViewModelState copyWith({
    String? errorTitle,
    String? login,
    String? password,
    bool? isProcess,
  }) {
    return _ViewModelState(
      errorTitle: errorTitle ?? this.errorTitle,
      login: login ?? this.login,
      password: password ?? this.password,
      isAuthInProcess: isProcess ?? this.isAuthInProcess,
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
    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  Future<void> onAuthButtonPrecess() async {
    final login = _state.login;
    final password = _state.password;

    if (login.isEmpty || password.isEmpty) return;
    _state = _state.copyWith(errorTitle: '', isProcess: true);
    try {
      await _authService.login(login, password);
      _state = _state.copyWith(errorTitle: '', isProcess: false);
    } on AuthApiProviderIsCorrectLoginDataProvider {
      _state = _state.copyWith(
          errorTitle: 'Неправильный логин или пароль', isProcess: false);
    } catch (exeption) {
      _state = _state.copyWith(
          errorTitle: 'Не удалось понять ошибку', isProcess: false);
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
        context.select((_ViewModel value) => value.state.authButtonState);
    final onPressed = buttonState == _ViewModelAuthButtonState.canSumbit
        ? model.onAuthButtonPrecess
        : null;
    final child = buttonState == _ViewModelAuthButtonState.authProgress
        ? const CircularProgressIndicator()
        : const Text('Авторизоваться');
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
