class AuthErrorApiDataProvider {}

class AuthApiProvider {
  Future<String> login(String login, String password) async {
    final isCorrect = (login == 'admin' && password == '12345');
    if (isCorrect) {
      return 'fdssfdsfds';
    } else {
      throw AuthErrorApiDataProvider();
    }
  }
}
