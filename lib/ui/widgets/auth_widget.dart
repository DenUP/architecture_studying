import 'package:architecture_studying/ui/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

// final login = TextEditingController();
// final password = TextEditingController();

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    final model = AuthModel();
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login'),
          TextFormField(
            controller: model.loginController,
          ),
          const Text('PSWD'),
          TextFormField(
            controller: model.passwordController,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                model.login(context, model.loginController.text,
                    model.passwordController.text);
              },
              child: const Text('Welcome GO'))
        ],
      ),
    ));
  }
}
