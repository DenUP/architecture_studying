import 'package:architecture_studying/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  // var user = User(0);

  Future<User> loadValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final age = sharedPreferences.getInt('age') ?? 0;
    return User(age);
  }

  Future<void> saveValue(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('age', user.age);
  }
}
