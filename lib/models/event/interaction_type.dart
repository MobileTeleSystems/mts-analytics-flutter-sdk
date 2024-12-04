/// Группа действий
///
/// non_interactions - хит без взаимодействия, используется для просмотров страниц/экранов
/// interactions - хиты взаимодействие пользователя с элементами интерфейса (клик по кнопке etc)
/// conversions - конверсионный хит (успех отправки заявки/формы etc)
library;

sealed class InteractionType {
  final String value;

  const InteractionType(this.value);
}

class NonInteractions extends InteractionType {
  const NonInteractions() : super('non_interactions');
}

class Interactions extends InteractionType {
  const Interactions() : super('interactions');
}

class Conversions extends InteractionType {
  const Conversions() : super('conversions');
}
