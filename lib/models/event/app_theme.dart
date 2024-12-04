/// Текущая тема, выбранная в приложении
///
/// Example: system_dark|system_light|user_dark|user_light|dark|light
///
/// Свои имена можно отправить через вариант Custom:
/// [AppTheme.Custom('my_theme')]
library;

sealed class AppTheme {
  final String value;
  const AppTheme(this.value);
}

class SysDark extends AppTheme {
  const SysDark() : super('system_dark');
}

class SysLight extends AppTheme {
  const SysLight() : super('system_light');
}

class UserDark extends AppTheme {
  const UserDark() : super('user_dark');
}

class UserLight extends AppTheme {
  const UserLight() : super('user_light');
}

class Dark extends AppTheme {
  const Dark() : super('dark');
}

class Light extends AppTheme {
  const Light() : super('light');
}

class Custom extends AppTheme {
  const Custom(super.value);
}
