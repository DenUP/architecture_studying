import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionDataProviderKey {
  static const _apiKey = 'api_key';
}

class SessionDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<String?> getApiKey() async {
    return (await _sharedPreferences).getString(SessionDataProviderKey._apiKey);
  }

  Future<void> saveApiKey(String key) async {
    (await _sharedPreferences).setString(SessionDataProviderKey._apiKey, key);
  }

  Future<void> clearApiKey() async {
    (await _sharedPreferences).remove(SessionDataProviderKey._apiKey);
  }
}
