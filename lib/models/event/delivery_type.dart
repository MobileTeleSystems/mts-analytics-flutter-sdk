/// Delivery Type
/// Выбранный способ доставки в оформленном заказе
///
/// Example: dostavka|samovyvoz
///
///
///
/// Свои имена можно отправить через вариант Custom:
/// [DeliveryType.Custom('parovoz')]
library;

sealed class DeliveryType {
  final String? value;
  const DeliveryType(this.value);
}

class Nullable extends DeliveryType {
  const Nullable() : super(null);
}

class Delivery extends DeliveryType {
  const Delivery() : super('dostavka');
}

class Pickup extends DeliveryType {
  const Pickup() : super('samovyvoz');
}

class Custom extends DeliveryType {
  const Custom(String super.value);
}
