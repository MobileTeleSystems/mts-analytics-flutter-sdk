import 'package:mts_analytics_plugin/ecommerce/ecommerce.dart';
import 'package:mts_analytics_plugin/models/event/event.dart';

extension ECommerceGA4EventExtension on ECommerceGA4Event {
  Map<String, Object?> toJson(String pluginVersion) {
    final Map<String, Object?> data = <String, Object?>{};
    final Map<String, Object?> eventData = <String, Object?>{};
    final Map<String, Object?> customData = <String, Object?>{};

    data['event'] = eventName.value;
    data['eventType'] = 'ecommerce_ga4';

    eventData['transactionId'] = transactionId;
    eventData['affiliation'] = affiliation;
    eventData['value'] = value;
    eventData['currency'] = currency;
    eventData['tax'] = tax;
    eventData['shipping'] = shipping;
    eventData['shippingTier'] = shippingTier;
    eventData['paymentType'] = paymentType;
    eventData['coupon'] = coupon;
    eventData['itemListName'] = itemListName;
    eventData['itemListId'] = itemListId;
    eventData['items'] = items?.map((item) => item.toJson()).toList();

    eventData['creativeName'] = creativeName;
    eventData['creativeSlot'] = creativeSlot;
    eventData['promotionId'] = promotionId;
    eventData['promotionName'] = promotionName;

    customData.addAll(customDimensions);
    customData['ma_flutter_plg_version'] = pluginVersion;
    eventData['customData'] = customData;

    data['eventData'] = eventData;

    return <String, Object?>{'parameters': data};
  }
}

extension ECommerceGA4EventItemExtension on ECommerceGA4EventItem {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'itemId': itemId,
      'itemName': itemName,
      'itemListName': itemListName,
      'itemListId': itemListId,
      'index': index,
      'itemBrand': itemBrand,
      'itemCategory': itemCategory,
      'itemCategory2': itemCategory2,
      'itemCategory3': itemCategory3,
      'itemCategory4': itemCategory4,
      'itemCategory5': itemCategory5,
      'itemVariant': itemVariant,
      'affiliation': affiliation,
      'discount': discount,
      'coupon': coupon,
      'price': price,
      'currency': currency,
      'quantity': quantity,
      'locationId': locationId,
      'creativeName': creativeName,
      'creativeSlot': creativeSlot,
      'promotionId': promotionId,
      'promotionName': promotionName,
    };

    data['customData'] = customDimensions;

    return data;
  }
}
