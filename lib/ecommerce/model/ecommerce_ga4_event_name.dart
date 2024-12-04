enum ECommerceGA4EventName {
  addPaymentInfo('add_payment_info'),
  addShippingInfo('add_shipping_info'),
  addToCart('add_to_cart'),
  addToWishlist('add_to_wishlist'),
  beginCheckout('begin_checkout'),
  purchase('purchase'),
  refund('refund'),
  removeFromCart('remove_from_cart'),
  selectItem('select_item'),
  selectPromotion('select_promotion'),
  viewCart('view_cart'),
  viewItem('view_item'),
  viewItemList('view_item_list'),
  viewPromotion('view_promotion');

  const ECommerceGA4EventName(this.value);
  final String value;
}
