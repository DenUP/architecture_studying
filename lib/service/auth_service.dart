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

  Future<bool> login(String login, String password) async {
    return true;
  }

  Future<void> logout() async {
    return;
  }
}
