/// Текущий тип подписки или тарифа пользователя внутри продукта,
/// если подписки нет, то 'null',
/// если использует триал, то 'trial'
///
/// Example: null|trial|premium|tarifische
///
/// Примеры своих имён,
/// которые можно отправить через вариант Custom [CurrentTariff.Custom('premium')]:
/// premium, tarifische
library;

sealed class CurrentTariff {
  final String value;
  const CurrentTariff(this.value);
}

class Null extends CurrentTariff {
  const Null() : super('null');
}

class Trial extends CurrentTariff {
  const Trial() : super('trial');
}

class Custom extends CurrentTariff {
  const Custom(super.value);
}
