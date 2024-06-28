import 'package:architecture_studying/domain/services/auth_servise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel {
  BuildContext context;
  final _authServise = AuthServise();

  _ViewModel(this.context) {
    init();
  }

  void init() async {
    final isAuth = await _authServise.checkAuth();
    if (isAuth) {
      _goToAppScreen();
    } else {
      _goToAuthScreen();
    }
  }

  void _goToAppScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('/example', (route) => false);
  }

  void _goToAuthScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  static Widget create() {
    return Provider(
      create: (context) => _ViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
