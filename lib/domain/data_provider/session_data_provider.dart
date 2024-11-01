import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionDataProviderKey {
  static const _apiKey = 'ApiKey';
}

class SessionDataProvider {
  final _storage = const FlutterSecureStorage();

  Future<String?> getApiKey() async {
    return await _storage.read(key: SessionDataProviderKey._apiKey);
  }

  Future<void> setApiKey(String value) async {
    return await _storage.write(
        key: SessionDataProviderKey._apiKey, value: value);
  }

  Future<void> clearApiKey() async {
    return await _storage.delete(key: SessionDataProviderKey._apiKey);
  }
}
