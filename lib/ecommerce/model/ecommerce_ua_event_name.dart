enum ECommerceUAEventName {
  checkoutOption('checkout_option'),
  add('add'),
  checkout('checkout'),
  purchase('purchase'),
  refund('refund'),
  remove('remove'),
  click('click'),
  promoClick('promo_click'),
  detail('detail'),
  impressions('impressions'),
  promoView('promo_view');

  const ECommerceUAEventName(this.value);
  final String value;
}
