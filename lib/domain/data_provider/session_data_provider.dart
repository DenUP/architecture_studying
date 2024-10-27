import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SessionDataProviderKey {
  static const _apiKey = 'api_key';
}

class SessionDataProvider {
  final secureStorage = const FlutterSecureStorage();

  Future<String?> loadApiKey() async {
    return await secureStorage.read(key: SessionDataProviderKey._apiKey);
  }

  Future<void> saveApiKey(String value) async {
    return await secureStorage.write(
        key: SessionDataProviderKey._apiKey, value: value);
  }
}
