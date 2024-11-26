/// Payment Type
/// Выбранный способ оплаты в оформленном заказе
///
/// Example: pri_poluchenii|seichas_onlain|rassrochka_onlain|rassrochka_v_salone_mts
///
/// Свои имена можно отправить через вариант Custom:
/// [PaymentType.Custom('pri_poluchenii_karta')]
sealed class PaymentType {
  final String? value;
  const PaymentType(this.value);
}

class Nullable extends PaymentType {
  const Nullable() : super(null);
}

class OnDelivery extends PaymentType {
  const OnDelivery() : super('pri_poluchenii');
}

class Online extends PaymentType {
  const Online() : super('seichas_onlain');
}

class InstallmentPaymentOnline extends PaymentType {
  const InstallmentPaymentOnline() : super('rassrochka_onlain');
}

class InstallmentPaymentOffice extends PaymentType {
  const InstallmentPaymentOffice() : super('rassrochka_v_salone_mts');
}

class Custom extends PaymentType {
  const Custom(String super.value);
}
