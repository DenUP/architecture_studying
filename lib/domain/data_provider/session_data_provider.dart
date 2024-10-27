import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionDataProviderKey {
  static const _apiKey = 'api_key';
}

// class SessionDataProvider {
//   final _sharedPreferences = SharedPreferences.getInstance();

//   Future<String?> getApiKey() async {
//     return (await _sharedPreferences).getString(SessionDataProviderKey._apiKey);
//   }

//   Future<void> saveApiKey(String key) async {
//     await (await _sharedPreferences)
//         .setString(SessionDataProviderKey._apiKey, key.toString());
//   }

//   Future<void> clearApiKey() async {
//     (await _sharedPreferences).remove(SessionDataProviderKey._apiKey);
//   }
// }

class SessionDataProvider {
  final _storage = const FlutterSecureStorage();

  Future<String?> getApiKey() async {
    return await _storage.read(key: SessionDataProviderKey._apiKey);
  }

  Future<void> saveApiKey(String value) async {
    return await _storage.write(
        key: SessionDataProviderKey._apiKey, value: value);
  }

  Future<void> clearApiKey() async {
    return _storage.delete(key: SessionDataProviderKey._apiKey);
  }
}
