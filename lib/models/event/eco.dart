/// Показывает принадлежность к экосистемному модулю.
/// Признак экосистемного продукта, в продукте МТС.
/// Используется только для модулей: модуль оплаты, логин (websso), ums.
/// Есть возможность добавлять своё значение в шаблон
///
/// Example: ums|login|mts_pay|custom_name
///
/// Свои имена можно отправить через вариант Custom:
/// [Eco.Custom('analytics')]
sealed class Eco {
  final String? value;
  const Eco(this.value);
}

class Nullable extends Eco {
  const Nullable() : super(null);
}

class Ums extends Eco {
  const Ums() : super('ums');
}

class Login extends Eco {
  const Login() : super('login');
}

class Payments extends Eco {
  const Payments() : super('mts_pay');
}

class Custom extends Eco {
  const Custom(String super.value);
}
