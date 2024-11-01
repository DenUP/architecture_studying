import 'package:architecture_studying/domain/data_provider/auth_api_provider.dart';
import 'package:architecture_studying/domain/data_provider/session_data_provider.dart';

class AuthService {
  final _authApiProvider = AuthApiProvider();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> checkAuth() async {
    final ApiKey = await _sessionDataProvider.getApiKey();
    if (ApiKey != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login(String login, String password) async {
    final key = await _authApiProvider.login(login, password);
    await _sessionDataProvider.setApiKey(key);
  }

  Future<void> logOut() async {
    await _sessionDataProvider.clearApiKey();
  }
}
