import 'package:mts_analytics_plugin/ecommerce/ecommerce.dart';
import 'package:mts_analytics_plugin/models/event/event.dart';

extension ECommerceUAEventExtension on ECommerceUAEvent {
  Map<String, Object?> toJson(String pluginVersion) {
    final Map<String, Object?> data = <String, Object?>{};
    final Map<String, Object?> eventData = <String, Object?>{};
    final Map<String, Object?> customData = <String, Object?>{};

    data['event'] = eventName.value;
    data['eventType'] = 'ecommerce_ua';
    eventData['ecommerce'] = ecommerce.toJson();
    eventData['currencyCode'] = currencyCode;
    eventData['ecommerceData'] = ecommerceParameters;
    final customProperties = customDimensions;
    if (customProperties != null) {
      customData.addAll(customProperties);
    }
    customData['ma_flutter_plg_version'] = pluginVersion;
    eventData['customData'] = customData;

    data['eventData'] = eventData;

    return <String, Object?>{'parameters': data};
  }
}

extension ECommerceUAExtension on ECommerceUA {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'purchase': purchase?.toJson(),
      'add': add?.toJson(),
      'checkoutOption': checkoutOption?.toJson(),
      'checkout': checkout?.toJson(),
      'refund': refund?.toJson(),
      'remove': remove?.toJson(),
      'click': click?.toJson(),
      'detail': detail?.toJson(),
      'impressions': impressions?.toJson(),
      'promoView': promoView?.toJson(),
      'promoClick': promoClick?.toJson(),
    };

    return data;
  }
}
