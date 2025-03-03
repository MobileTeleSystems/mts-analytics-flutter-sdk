import 'package:mts_analytics_plugin/ecommerce/ecommerce.dart';

import 'account_type.dart' as account_type;
import 'interaction_type.dart' as interaction_type;
import 'app_theme.dart' as app_theme;
import 'auth_type.dart' as auth_type;
import 'button_location.dart' as button_location;
import 'current_tariff.dart' as current_tariff;
import 'delivery_type.dart' as delivery_type;
import 'action.dart' as act;
import 'target.dart' as tg;

import 'ep_availability.dart' as ep_availability;
import 'epdt.dart' as epdt;
import 'eppl.dart' as eppl;
import 'eco.dart' as m_eco;
import 'multi_account_type.dart' as multi_account_type;
import 'payment_type.dart' as payment_type;
import 'product_category.dart' as product_category;
import 'touch_point.dart' as touch_point;

import 'ename.dart' as e_name;

sealed class Event {
  Event();
}

extension EventExtension on Event {
  Map<String, Object?> toJson(String pluginVersion) {
    if (this is MtsEvent) {
      return (this as MtsEvent).toJson(pluginVersion);
    } else if (this is CustomEvent) {
      return (this as CustomEvent).toJson(pluginVersion);
    } else if (this is ScreenEvent) {
      return (this as ScreenEvent).toJson(pluginVersion);
    } else if (this is ErrorEvent) {
      return (this as ErrorEvent).toJson(pluginVersion);
    } else if (this is ECommerceGA4Event) {
      return (this as ECommerceGA4Event).toJson(pluginVersion);
    } else if (this is ECommerceUAEvent) {
      return (this as ECommerceUAEvent).toJson(pluginVersion);
    } else {
      return <String, Object?>{};
    }
  }
}

class MtsEvent extends Event {
  /// Глобальная категория элементов взаимодействия
  /// (если есть возможность сгруппировать корректно)
  ///
  /// Популярные примеры в экосистеме МТС:
  /// galereya, widgety, trek, zvonki, pleer, chitalka,
  /// glavnaya, podborki, katalog, razgovor, stories,
  /// izbrannoe, kontrol_rashodov, mobilnaya_svyaz, sdk_cashback,
  /// neavtorizovannaya_zona, avtorizaciya, onboarding,
  /// kontakty, redaktirovanie_kontakta, esche, podpiska,
  /// nastroiki, ocenka_prilozhenia, podderzhka, napisat_v_podderzhku,
  /// filter, dialog, drugoe
  String eventCategory;

  /// Название элемента (кнопки, баннера, элемента, гиперссылки),
  /// из карты переходов приложения.
  /// Необходима проработка карты переходов приложения со скриншотами.
  /// По аналогии с web: 'sitemap'
  ///
  /// Примеры имён:
  /// voiti, uspeshnaya_avtorizaciya, ne_uspeshnaya_avtorizaciya,
  /// onboarding_nachalo, onboarding_konez, kontakty, obnovit_kontakty,
  /// dobavit, redaktirovat, udalit, gotovo
  String eventLabel;

  /// Дополнительный, верхнеуровневый атрибут/св-во элемента взаимодействия
  ///
  /// Примеры имён:
  /// podpiska, muzyka, video, atach, ssylki, form
  String? eventContent;

  /// Дополнительный, нижненеуровневый артибут/св-во элемента взаимодействия
  ///
  /// Примеры имён:
  /// on, off, tarif_monthly_299rub
  String? eventContext;
  int? eventValue;
  interaction_type.InteractionType interactionType;
  touch_point.TouchPoint touchPoint;
  button_location.ButtonLocation buttonLocation;
  tg.Target target;
  act.Action action;

  /// Идентификатор пользователя: Firebase installation id
  /// [https://firebase.google.com/docs/reference/android/com/google/firebase/installations/FirebaseInstallations#getId()]
  ///
  /// Example: ebtQL47cHrk
  String clientId;

  /// ВАЖНО! mclientID присваивается при первом входе пользователя в аппку
  /// и сохраняется в local storage приложения.
  /// Не перезаписывается при каждой новой сессии пользователя, или после обновления приложения.
  /// Пример для js:
  /// Math.trunc(Math.random()*Math.pow(10, 10))+Math.trunc(Date.now()/1000)
  ///
  /// Example: 93270144851671100000
  ///
  String mClientId;

  /// {mclientID}_{timeStamp первого хита в сеансе}
  ///
  /// Example: 93270144851671100000_1680427772409
  ///
  String sessionId;

  /// {mclientID}_{timeStamp}
  ///
  /// Example: 93270144851671100000_1680439999409
  ///
  String hitId;

  /// Время совершения действия на стороне пользователя в формате UNIX, мс.
  /// Именно это время является второй частью [hitId]
  ///
  /// Example: 1680427772409
  String timestamp;

  /// Id пользователя из профиля web SSO: webSSO guid,
  /// где webSSO guid - это уникальный идентификатор пользователя,
  /// который WebSSO присваивает и хранит на своей стороне (profile:guid)
  ///
  /// Example: jehrg234-234hkj-234jkhghj-efgj4
  String userId;

  /// Product UID
  /// Опиционально, для продуктов с собственной авторизацией.
  /// Идентификатор пользователя внутри продукта
  ///
  /// Example: 1a2b3c4
  String? grClientId;

  /// Profile Status.
  /// Опиционально, для продуктов с авторизацией.
  /// Статус подтверждения профиля пользователя
  ///
  /// Example: fCj6fvgxypE_20080610152447302
  String? grId;

  /// Advert ID.
  /// Рекламный идентификатор устройства пользователя (ios — IDFA, android — gaid)
  ///
  /// AdvertisingIdClient.getAdvertisingIdInfo(context).id?
  ///
  /// Example: br7ac10b-55cc-4372-a534-0e02b2c3d479
  ///
  String? aId;

  /// Device ID.
  /// Идентификатор устройства пользователя, одинаковый для всех приложений на устройстве.
  /// (ios — IDFV, android — ANDROID_ID).
  ///
  /// Example:
  /// 'Android d24b5a970278d1d8',
  /// 'iOS 2b6f0cc904d137be2e1730235f5664094b831186'
  ///
  String? dId;
  auth_type.AuthType userAuth;

  /// Название проекта, в чей продукт интегрируется разметка
  ///
  /// Example: poisk, stroki, mymts
  String projectName;

  /// Название фильтра/вкладки.
  /// В случае нескольких активных фильтров, необходимо использовать вертикальную черту.
  /// Значение фильтра передаётся в полях, передающих содержимое и значения.
  ///
  /// @see eventContent
  /// @see eventContext
  /// @see eventValue
  ///
  /// Example: time|single|high|low
  String? filterName;

  /// Название продукта,
  /// с которым происходит взаимодействие внутри проекта (название тарифа, услуги и пр.)
  String? productName;

  /// ID продукта,
  /// с которым происходит взаимодействие внутри проекта (ID тарифа, услуги и пр.)
  String? productId;

  /// Название воронки.
  /// Процесса из нескольких шагов
  ///
  /// Example: fnl_sales
  String? funnelName;

  /// Шаг воронки
  ///
  /// Example: fnl_sales_st1|fnl_sales_st2|fnl_sales_st3
  String? funnelStep;

  /// ID формы, с которой происходит взаимодействие
  String? formId;

  /// ID отправленной заявки
  String? formOrderId;
  multi_account_type.MultiAccountType multiAccountType;
  account_type.AccountType accountType;

  /// Название баннера
  ///
  /// Example: DCM_nabber_cashback
  String? bannerName;

  /// Id баннера (для показов и кликов по баннерам)
  ///
  /// Example: 4534534
  String? bannerId;

  /// Название региона посетителя, выбранного в приложении.
  /// Например приложение определило, что регион клиента МСК,
  /// отображает регион в приложении, использует для доставки товаров и т.п.
  /// Эту информацию передаём как есть
  ///
  /// Example: moskva|moskva_i_moskovskaya_oblast
  String region;

  /// Используются для проведения a/b test
  String? abName;

  /// Используются для проведения a/b test
  String? abVariant;
  current_tariff.CurrentTariff currentTariff;
  payment_type.PaymentType paymentType;
  delivery_type.DeliveryType deliveryType;

  /// Event Position
  /// Порядковый номер объекта взаимодействия:
  /// поле в анкете, карточки в каталоге, баннеры в блоке баннеров и пр.
  ///
  /// Example: 1|2|3|4|5
  String? eventPosition;
  eppl.EPPL eventProductPromoLabel;
  ep_availability.EPAvailability eventProductAvailable;
  epdt.EPDT eventProductDeliveryTerms;
  app_theme.AppTheme appTheme;
  m_eco.Eco eco;

  /// Profile Type
  /// Опционально, для продуктов с авторизацией.
  /// Для отслеживания различных типов профиля
  ///
  /// Example: general|employee
  String? profileType;
  product_category.ProductCategory productCategory;

  /// Идентификатор пользователя, который генерируется SDK Appsflyer
  /// при первом открытии приложения после установки
  ///
  /// Example: 1661431768043-2213402944332562490
  String? appsflyerId;

  /// Название экрана/страницы, необходима проработка карты переходов приложения со скриншотами.
  /// По аналогии с web: 'sitemap'
  String screenName;
  e_name.EName eventName;
  Map<String, Object?> customDimensions;

  MtsEvent({
    this.eventCategory = '',
    this.eventLabel = '',
    this.eventContent,
    this.eventContext,
    this.eventValue,
    this.interactionType = const interaction_type.NonInteractions(),
    this.touchPoint = const touch_point.App(),
    this.buttonLocation = const button_location.Nullable(),
    this.target = const tg.Empty(),
    this.action = const act.Empty(),
    required this.clientId,
    required this.mClientId,
    required this.sessionId,
    required this.hitId,
    required this.timestamp,
    this.userId = '',
    this.grClientId,
    this.grId,
    this.aId,
    this.dId,
    this.userAuth = const auth_type.NotAuth(),
    required this.projectName,
    this.filterName,
    this.productName,
    this.productId,
    this.funnelName,
    this.funnelStep,
    this.formId,
    this.formOrderId,
    this.multiAccountType = const multi_account_type.Nullable(),
    this.accountType = const account_type.Nullable(),
    this.bannerName,
    this.bannerId,
    required this.region,
    this.abName,
    this.abVariant,
    this.currentTariff = const current_tariff.Null(),
    this.paymentType = const payment_type.Nullable(),
    this.deliveryType = const delivery_type.Nullable(),
    this.eventPosition,
    this.eventProductPromoLabel = const eppl.Nullable(),
    this.eventProductAvailable = const ep_availability.Nullable(),
    this.eventProductDeliveryTerms = const epdt.Nullable(),
    this.appTheme = const app_theme.Light(),
    this.eco = const m_eco.Nullable(),
    this.profileType,
    this.productCategory = const product_category.Nullable(),
    this.appsflyerId,
    required this.screenName,
    required this.eventName,
    this.customDimensions = const {},
  });
}

extension MtsEventExtension on MtsEvent {
  Map<String, Object?> toJson(String pluginVersion) {
    final Map<String, Object?> data = <String, Object?>{};
    data['event'] = eventName.toEventName(); //Посмотреть позже
    data['eventType'] = eventName.toEventType(); //Посмотреть позже
    data['title'] = screenName;
    final Map<String, Object?> contentObject = <String, Object?>{};
    contentObject.addAll(customDimensions);
    contentObject['ClientID'] = clientId;
    contentObject['mclientID'] = mClientId;
    contentObject['TimeStamp'] = timestamp;
    contentObject['ScreenName'] = screenName;
    contentObject['EventName'] = eventName.value;
    contentObject['EventLabel'] = eventLabel;
    contentObject['EventCategory'] = eventCategory;
    contentObject['InteractionType'] = interactionType.value;
    contentObject['EventAction'] = targetWithAction(target, action);
    contentObject['TouchPoint'] = touchPoint.value;
    contentObject['SessionID'] = sessionId;
    contentObject['HitID'] = hitId;
    contentObject['ProjectName'] = projectName;
    contentObject['CurrentTariff'] = currentTariff.value;
    contentObject['AppTheme'] = appTheme.value;
    contentObject['Region'] = region;
    contentObject['EventContent'] = eventContent;
    contentObject['EventContext'] = eventContext;
    contentObject['EventValue'] = eventValue;
    contentObject['ButtonLocation'] = buttonLocation.value;
    contentObject['AppsFlyerID'] = appsflyerId;
    contentObject['UserID'] = userId;
    contentObject['GRClientID'] = grClientId;
    contentObject['GRID'] = grId;
    contentObject['AdvertID'] = aId;
    contentObject['DeviceID'] = dId;
    contentObject['UserAuth'] = userAuth.value;
    contentObject['FilterName'] = filterName;
    contentObject['ProductName'] = productName;
    contentObject['ProductId'] = productId;
    contentObject['funnelName'] = funnelName;
    contentObject['funnelStep'] = funnelStep;
    contentObject['FormID'] = formId;
    contentObject['FormOrderId'] = formOrderId;
    contentObject['MultiAccountType'] = multiAccountType.value;
    contentObject['AccountType'] = accountType.value;
    contentObject['BannerName'] = bannerName;
    contentObject['BannerId'] = bannerId;
    contentObject['abName'] = abName;
    contentObject['abVariant'] = abVariant;
    contentObject['PaymentType'] = paymentType.value;
    contentObject['DeliveryType'] = deliveryType.value;
    contentObject['EventPosition'] = eventPosition;
    contentObject['EventProductPromoLabel'] = eventProductPromoLabel.value;
    contentObject['EventProductAvailability'] = eventProductAvailable.value;
    contentObject['EventProductDeliveryTerms'] =
        eventProductDeliveryTerms.value;
    contentObject['Eco'] = eco.value;
    contentObject['ProfileType'] = profileType;
    contentObject['ProductCategory'] = productCategory.value;
    contentObject['ma_flutter_plg_version'] = pluginVersion;
    data['contentObject'] = contentObject;
    return <String, Object?>{'parameters': data};
  }
}

class CustomEvent extends Event {
  String eventName;
  String screenName;
  Map<String, Object?> customDimensions;
  CustomEvent({
    this.screenName = '',
    this.eventName = '',
    this.customDimensions = const {},
  });
}

extension CustomEventExtension on CustomEvent {
  Map<String, Object?> toJson(String pluginVersion) {
    final Map<String, Object?> data = <String, Object?>{};
    data['event'] = eventName;
    data['eventType'] = 'event';
    data['title'] = screenName;
    final Map<String, Object?> contentObject = <String, Object?>{};
    contentObject.addAll(customDimensions);
    contentObject['ma_flutter_plg_version'] = pluginVersion;
    data['contentObject'] = contentObject;
    return <String, Object?>{'parameters': data};
  }
}

class ECommerceUAEvent extends Event {
  final ECommerceUAEventName eventName;
  final Map<String, Object?>? customDimensions;
  final Map<String, Object?>? ecommerceParameters;
  final ECommerceUA ecommerce;
  final String? currencyCode;

  ECommerceUAEvent({
    required this.eventName,
    this.customDimensions,
    this.ecommerceParameters,
    required this.ecommerce,
    this.currencyCode,
  });
}

class ECommerceGA4Event extends Event {
  final ECommerceGA4EventName eventName;
  final Map<String, Object?> customDimensions;
  final Map<String, Object?> ecommerceParameters;
  final String? transactionId;
  final String? affiliation;
  final String? value;
  final String? currency;
  final String? tax;
  final String? shipping;
  final String? shippingTier;
  final String? paymentType;
  final String? coupon;
  final String? itemListName;
  final String? itemListId;
  final List<ECommerceGA4EventItem>? items;
  final String? creativeName;
  final String? creativeSlot;
  final String? promotionId;
  final String? promotionName;

  ECommerceGA4Event({
    required this.eventName,
    this.customDimensions = const {},
    this.ecommerceParameters = const {},
    this.transactionId,
    this.affiliation,
    this.value,
    this.currency,
    this.tax,
    this.shipping,
    this.shippingTier,
    this.paymentType,
    this.coupon,
    this.itemListName,
    this.itemListId,
    this.items,
    this.creativeName,
    this.creativeSlot,
    this.promotionId,
    this.promotionName,
  });
}

class ScreenEvent extends Event {
  String eventName;
  String screenName;
  Map<String, Object?> customDimensions;
  ScreenEvent({
    this.eventName = '',
    required this.screenName,
    this.customDimensions = const {},
  });
}

extension ScreenEventExtension on ScreenEvent {
  Map<String, Object?> toJson(String pluginVersion) {
    final Map<String, Object?> data = <String, Object?>{};
    data['event'] = eventName;
    data['eventType'] = 'screenview';
    data['title'] = screenName;
    final Map<String, Object?> contentObject = <String, Object?>{};
    contentObject.addAll(customDimensions);
    contentObject['ma_flutter_plg_version'] = pluginVersion;
    data['contentObject'] = contentObject;
    return <String, Object?>{'parameters': data};
  }
}

class ErrorEvent extends Event {
  String eventName;
  String errMsg;
  Exception? exception;
  StackTrace? stackTrace;
  String screenName;
  Map<String, Object?> customDimensions;

  ErrorEvent({
    this.eventName = '',
    this.errMsg = '',
    this.exception,
    this.stackTrace,
    this.screenName = '',
    this.customDimensions = const {},
  });
}

extension ErrorEventExtension on ErrorEvent {
  Map<String, Object?> toJson(String pluginVersion) {
    final Map<String, Object?> data = <String, Object?>{};
    data['event'] = eventName;
    data['eventType'] = 'custom_error';
    data['title'] = screenName;
    data['stackTrace'] = exception.getResultString(stackTrace, errMsg);
    final Map<String, Object?> contentObject = <String, Object?>{};
    contentObject.addAll(customDimensions);
    contentObject['ma_flutter_plg_version'] = pluginVersion;
    data['contentObject'] = contentObject;
    return <String, Object?>{'parameters': data};
  }
}

extension ExceptionExtension on Exception? {
  String getResultString(StackTrace? stackTrace, String errMsg) {
    var buffer = StringBuffer();
    if (errMsg.isNotEmpty) {
      buffer.writeln(errMsg);
    }
    if (this != null) {
      buffer.writeln(toString());
    }
    if (stackTrace != null) {
      buffer.writeln(stackTrace);
    }
    return buffer.toString();
  }
}

String targetWithAction(tg.Target target, act.Action action) {
  String delimiter = '_';
  if (target is tg.Empty && action is act.Empty) {
    return '';
  } else if (target is tg.Empty) {
    return action.value;
  } else if (action is act.Empty) {
    return target.value;
  } else {
    return '${target.value}$delimiter${action.value}';
  }
}
