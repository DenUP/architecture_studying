abstract class AuthProviderError {}

class AuthProviderIncorectLoginDataError {}

class AuthApiProvider {
  Future<String> login(String login, String password) async {
    final isSuccess = login == 'admin' && password == 'admin';
    if (isSuccess) {
      return 'Asaldasdaaaaaaaaa';
    } else {
      throw {AuthProviderIncorectLoginDataError};
    }
  }
}
