abstract class AuthApiProviderError {}

class AuthApiProviderIsCorrectLoginDataProvider {}

class AuthApiProvider {
  Future<String> login(String login, String password) async {
    final isCorrect = (login == 'admin' && password == '123456');
    if (isCorrect) {
      return 'fddsfdsfdsfsd';
    } else {
      throw AuthApiProviderIsCorrectLoginDataProvider;
    }
  }
}
