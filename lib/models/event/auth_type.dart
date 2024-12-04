/// Признак авторизации пользователя. Авторизован да=1, нет=0
///
/// Заполняется, если есть userId
///
/// Example: 1|0
sealed class AuthType {
  final String value;
  const AuthType(this.value);
}

class Auth extends AuthType {
  const Auth() : super('1');
}

class NotAuth extends AuthType {
  const NotAuth() : super('0');
}
