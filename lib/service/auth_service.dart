import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/domain/data_provider/session_data_provider.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final _authApiProvider = AuthApiProvider();

  Future<bool> checkAuth() async {
    final apiKey = await _sessionDataProvider.getApiKey();
    if (apiKey != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login(String login, String password) async {
    final key = await _authApiProvider.login(login, password);
    await _sessionDataProvider.saveApiKey(key.toString());
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearApiKey();
  }
}
