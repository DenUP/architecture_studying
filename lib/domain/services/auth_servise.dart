import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/domain/data_provider/session_data_provider.dart';

class AuthServise {
  final _sessionDataProvider = SessionDataProvider();
  final _authApiProvider = AuthApiProvider();

  Future<bool> checkAuth() async {
    final apiKey = await _sessionDataProvider.getApiKey();
    return apiKey != null;
  }

  Future<bool> login(String login, String password) async {
    final apiKey = await _authApiProvider.login(login, password);
    await _sessionDataProvider.saveApiKey(apiKey);
    return true;
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearApiKey();
  }
}
