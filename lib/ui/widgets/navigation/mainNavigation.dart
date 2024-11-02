import 'package:flutter/material.dart';

class Mainnavigation {
  static void showLoader(context) =>
      Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
}
