import 'package:architecture_studying/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel {
  BuildContext context;
  final _authService = AuthService();

  _ViewModel(this.context) {
    init();
  }
  void init() async {
    final isAuth = await _authService.checkAuth();
    if (isAuth) {
      Navigator.of(context).pushNamedAndRemoveUntil('/example', (router) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/auth', (router) => false);
    }
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
