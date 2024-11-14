import 'package:architecture_studying/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProviders {
  final sharedPref = SharedPreferences.getInstance();

  Future<User> loadValue() async {
    final age = (await sharedPref).getInt('age') ?? 0;
    return User(age);
  }

  Future<void> saveValue(User user) async {
    (await sharedPref).setInt('age', user.age);
  }
}
