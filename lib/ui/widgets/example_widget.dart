import 'package:architecture_studying/service/auth_service.dart';
import 'package:architecture_studying/ui/widgets/navigation/mainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  Future<void> onClickButtonLogOut(context) async {
    await _authService.logOut();
    Mainnavigation.showLoader(context);
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const ExampleWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () => model.onClickButtonLogOut(context),
              child: Text('Выход'))
        ],
      ),
      body: SafeArea(child: Text('Главная страница')),
    );
  }
}
