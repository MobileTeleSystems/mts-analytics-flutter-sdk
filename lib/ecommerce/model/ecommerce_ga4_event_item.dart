class ECommerceGA4EventItem {
  final String itemId;
  final String itemName;
  final String? itemListName;
  final String? itemListId;
  final String? index;
  final String? itemBrand;
  final String? itemCategory;
  final String? itemCategory2;
  final String? itemCategory3;
  final String? itemCategory4;
  final String? itemCategory5;
  final String? itemVariant;
  final String? affiliation;
  final String? discount;
  final String? coupon;
  final String? price;
  final String? currency;
  final String? quantity;
  final String? locationId;
  final String? creativeName;
  final String? creativeSlot;
  final String? promotionId;
  final String? promotionName;
  final Map<String, Object?>? customDimensions;

  ECommerceGA4EventItem({
    required this.itemId,
    required this.itemName,
    this.itemListName,
    this.itemListId,
    this.index,
    this.itemBrand,
    this.itemCategory,
    this.itemCategory2,
    this.itemCategory3,
    this.itemCategory4,
    this.itemCategory5,
    this.itemVariant,
    this.affiliation,
    this.discount,
    this.coupon,
    this.price,
    this.currency,
    this.quantity,
    this.locationId,
    this.creativeName,
    this.creativeSlot,
    this.promotionId,
    this.promotionName,
    this.customDimensions,
  });
}
