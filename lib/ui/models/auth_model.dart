import 'package:architecture_studying/service/auth_service.dart';
import 'package:flutter/widgets.dart';

class AuthModel {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  Future<void> login(
      BuildContext context, String login, String password) async {
    await _authService.login(login, password);

    Navigator.pushNamed(context, '/home');
  }
}
