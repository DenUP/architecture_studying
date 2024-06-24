import 'dart:math';

import 'package:architecture_studying/domain/data_provider/user_data_provider.dart';
import 'package:architecture_studying/domain/entity/user.dart';

class UserServise {
  final _userDataProvider = UserDataProvider();
  var _user = User(0);
  User get user => _user;

  Future<void> initialize() async {
    _user = await _userDataProvider.loadValue();
  }

  void increment() {
    // final user = _userDataProvider.user;
    _user = _user.copyWith(age: user.age + 1);
    _userDataProvider.saveValue(user);
  }

  void decrement() {
    // final user = _userDataProvider.user;
    _user = _user.copyWith(age: max(user.age - 1, 0));
    _userDataProvider.saveValue(user);
  }
}
