/// Тип аккаунта в разрезе принадлежности бизнеса (для myMTS).
/// Определяется по полю webSSO 'profile:type'
/// Мобильная связь - mobile
/// Фиксированная связь и СТВ - stv
/// Фиксированная связь - fix
/// Виртуальный номер - mobile
/// МТС Коннект - mobile
/// Безопасное детство - mobile
/// Госуслуги - other
/// mgts, mrmsk - mgts
/// Домашний интернет - fix
///
/// Example: mobile|stv|fix|mgts|other_operators
///
/// Свои имена можно отправить через вариант Custom:
/// [AccountType.Custom('another_operator')]
library;

sealed class AccountType {
  final String? value;
  const AccountType(this.value);
}

class Nullable extends AccountType {
  const Nullable() : super(null);
}

class Mobile extends AccountType {
  const Mobile() : super('mobile');
}

class Stv extends AccountType {
  const Stv() : super('stv');
}

class Fix extends AccountType {
  const Fix() : super('fix');
}

class Mgts extends AccountType {
  const Mgts() : super('mgts');
}

class Others extends AccountType {
  const Others() : super('other_operators');
}

class Custom extends AccountType {
  const Custom(String super.value);
}
