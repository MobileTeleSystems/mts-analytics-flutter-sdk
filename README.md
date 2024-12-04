# mts_analytics_plugin

Плагин от МТС Аналитики для Flutter

## Установка

В pubspec.yaml добавить зависимость:

```yaml
  mts_analytics_plugin:
    git:
      url: git@github.com:MobileTeleSystems/mts-analytics-flutter-sdk.git
      ref: 1.7.0
```

Пример подключения: <https://github.com/MobileTeleSystems/mts-analytics-flutter-sdk/tree/master/example>

### Android

#### Требования

* Kotlin 1.7.10+
* AGP 7.3.0+
* Android SDK 21+
* Target SDK 34

#### Интеграция

Необходимо добавить в .gradle вашего проекта зависимости на maven репозитории:

```groovy
allprojects {
    repositories {
        maven {
            name "mts_analytics_sdk_external"
            url "https://packages.a.mts.ru/repository/maven-releases/"
        }
    }
}
```

### iOS

#### Требования

iOS 13.0+
tvOS 13.0+

#### Интеграция

Добавить в podfile проекта

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/MobileTeleSystems/mts-analytics-podspecs'

pod 'MTMetrics', '~> 3.1.0'
```

## Использование

### Инициализация

При инициализации вы должны передать Config с обязательным параметром **androidFlowId/iosFlowId**, который будет выдаваться при регистрации вашего приложения в нашей системе. Остальные параметры опциональны.

```dart
MtsAnalyticsConfig config = MtsAnalyticsConfig()
      ..logLevel = LogLevel.DEBUG
      ..crashReportingEnabled = true
      ..backgroundTimeout = 120
      ..activeTimeout = 90
      ..eventStorageLimit = 3000
      ..networkTrafficEnabled = false
      ..androidFlowId = ""
      ..iosFlowId = "";
    MtsAnalyticsPlugin().init(config);
```

### Обновление конфигурации

```dart
MtsAnalyticsConfig config = MtsAnalyticsConfig()
      ..logLevel = LogLevel.OFF
      ..crashReportingEnabled = false
      ..backgroundTimeout = 20
      ..activeTimeout = 45
      ..eventStorageLimit = 1500
      ..networkTrafficEnabled = true
      ..androidFlowId = ""
      ..iosFlowId = "";
    MtsAnalyticsPlugin().updateConfig(config);
```

### Отправка событий

```dart
  MtsAnalyticsPlugin().trackEvent
  MtsAnalyticsPlugin().trackEventName(eventName)
  MtsAnalyticsPlugin().trackEventWithParameter(eventName, key);
  MtsAnalyticsPlugin().trackEventWithKeyValue(eventName, key, value);
  MtsAnalyticsPlugin().trackEventWithMap(eventName, map);
```

### Пример отправки события mtsEvent (использовать именно MtsEvent для всех команд MTS)

```dart
  MtsEvent mtsEvent = MtsEvent(
    eventCategory: "eventCategoryTest",
    eventLabel: "eventLabelTest",
    eventContent: "eventContentTest",
    eventContext: "eventContextTest",
    eventValue: 124,
    interactionType: const interaction_type.NonInteractions(),
    touchPoint: const touch_point.App(),
    buttonLocation: const button_location.TopBar(),
    target: const tg.Banner(),
    action: const act.Play(),
    clientId: "ebtQL47cHrk",
    mClientId: "93270144851671100000",
    sessionId: "93270144851671100000_1680427772409",
    hitId: "93270144851671100000_1680439999409",
    timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    userId: "userTestId",
    grClientId: "1a2b3c4grClient",
    grId: "fCj6fvgxypE_20080610152447302",
    aId: "br7ac10b-55cc-4372-a534-0e02b2c3d479",
    dId: "d24b5a970278d1d8",
    userAuth: const auth_type.Auth(),
    projectName: "2memory",
    filterName: "time|single|high|low",
    productName: "2memoryAndroid",
    productId: "productId",
    funnelName: "fnl_sales",
    funnelStep: "fnl_sales_st1",
    formId: "form1",
    formOrderId: "formOrderId",
    multiAccountType: const multi_account_type.Parent(),
    accountType: const account_type.Fix(),
    bannerName: "DCM_nabber_cashback",
    bannerId: "4534534",
    region: "Ufa",
    abName: "a/b test",
    abVariant: "a/b test variant",
    currentTariff: const current_tariff.Trial(),
    paymentType: const payment_type.InstallmentPaymentOnline(),
    deliveryType: const delivery_type.Pickup(),
    eventPosition: "23",
    eventProductPromoLabel: const eppl.NotSet(),
    eventProductAvailable: const ep_availability.PreOffer(),
    eventProductDeliveryTerms: const epdt.Pickup(),
    appTheme: const app_theme.Dark(),
    eco: const m_eco.Payments(),
    profileType: "employee",
    productCategory: const product_category.BankCard(),
    appsflyerId: "1661431768043-2213402944332562490",
    screenName: "MainActivity",
    eventName: e_name.Custom(value: "test"),
    customDimensions: {
      "customParameter": "1",
      "customParameter2": 1,
      "customParameter3": 1.123123124,
      "customParameter4": true,
      "customParameter5": null,
      "customParameter6": [1, "1", null, true, 1.1],
      "customParameter7": {
        "customParameter": "1",
        "customParameter2": 1,
        "customParameter3": 1.123123124,
        "customParameter4": true,
        "customParameter5": null,
      }
    }
);

  MtsAnalyticsPlugin().trackEvent(mtsEvent);
```

### Пример отправки события screenEvent

```dart
    ScreenEvent event = ScreenEvent(
        screenName: "MainActivityScreen",
        customDimensions: {
          "customParameter": "1",
          "customParameter2": 1,
          "customParameter3": 1.123123124,
          "customParameter4": true,
          "customParameter5": null,
          "customParameter6": [1, "1", null, true, 1.1],
          "customParameter7": {
            "customParameter": "1",
            "customParameter2": 1,
            "customParameter3": 1.123123124,
            "customParameter4": true,
            "customParameter5": null,
          }
        }
    );

    MtsAnalyticsPlugin().trackEvent(event);
```

### Пример отправки события customEvent (если предыдущие вам не подошли)

```dart
    CustomEvent event = CustomEvent(
        screenName: "MainActivityScreen",
        eventName: const e_name.Screen(),
        customDimensions: {
          "customParameter": "1",
          "customParameter2": 1,
          "customParameter3": 1.123123124,
          "customParameter4": true,
          "customParameter5": null,
          "customParameter6": [1, "1", null, true, 1.1],
          "customParameter7": {
            "customParameter": "1",
            "customParameter2": 1,
            "customParameter3": 1.123123124,
            "customParameter4": true,
            "customParameter5": null,
          }
        }
    );
    MtsAnalyticsPlugin().trackEvent(event);
```

### Отслеживание кроссплатформы

```dart
    MtsAnalyticsPlugin().getWebSessionQuery("https://mts.ru");
```

### Отправка события аутентификации

```dart
  String ssoState = "234234111";
  String redirectUrl = "https://client-analytics.mts.ru/api/mts-sso/callback";
  MtsAnalyticsPlugin().sendAuthenticationEvent(ssoState, redirectUrl);
```

### Отправка геолокации

```dart
    double latitude = 55.75;
    double longitude = 37.6167;
    mtsAnalyticsPlugin.setLocation(latitude, longitude);
```

### Link manager

#### Отправка событий Uri

В плагине имеется возможность отправки события перехода по Deeplink. Deeplink можно получить используя пакет [go_router](https://pub.dev/documentation/go_router/latest/topics/Deep%20linking-topic.html)

```dart
GoRoute(
    path: '/',
    builder: (_, __) => HomePage(
      title: 'SDK Demo Home Page',
      mtsAnalyticsPlugin: mtsAnalyticsPlugin,
    ),
    routes: [
        GoRoute(
            name: LinkmanagerPage.route,
            path: LinkmanagerPage.path,
            builder: (_, goRouterState) {
                mtsAnalyticsPlugin.trackUri(uri: goRouterState.uri);
                return LinkmanagerPage(
                    uri: goRouterState.uri,
                    mtsAnalyticsPlugin: mtsAnalyticsPlugin,
                )
            },
        )
    ]
);
/// Можно отправить событие с произвольной ссылкой
final url = 'http:\\shop.mts.ru'
mtsAnalyticsPlugin.trackUri(uri: Uri.parse(url));
```

#### Получение параметров ссылки сформированной в Link manager

Начиная с версии плагина МТС Аналитики `1.6.0`, добавлена возможность получения данных из короткой ссылки,
которая была заранее сгенерирована в `LinkManager`. Короткая ссылка также может являться `deeplink` в приложении.
Для работы с `deeplink` сгенерируйте ссылку согласно инструкции в 'LinkManager' и поддержите их в своем  [приложении](https://docs.flutter.dev/ui/navigation/deep-linking) используя пакет [go_router](https://pub.dev/documentation/go_router/latest/topics/Deep%20linking-topic.html)

Если продукт перехватил `deeplink`, содержащий такую ссылку или в приложении уже есть короткая ссылка,
то можно получить параметры из неё:

```dart
`resolveLink(uri: Uri): DeeplinkResult`
```

например:

```dart
final MtsAnalyticsConfig config = MtsAnalyticsConfig()
    ..logLevel = LogLevel.verbose
    ..crashReportingEnabled = false
    ..backgroundTimeout = 120
    ..activeTimeout = 90
    ..eventStorageLimit = 3000
    ..networkTrafficEnabled = true
    ..androidFlowId = androidFlowId
    ..iosFlowId = iosFlowId;
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);


final uri = Uri.parse("https://url.mts.ru/short_link")

final DeepLinkResult result = await mtsAnalyticsPlugin.resolveLink(uri: uri)

```

`DeepLinkResultSuccess` содержит: `location`(url редиректа) и `params`(набор параметров полученных из Link Manager)
Вложенность `params` может быть не более 3 уровней.
`DeepLinkResultError` содержит: `error` (сообщение об ошибке)

```dart
sealed class DeepLinkResult {
  const DeepLinkResult();
}

@JsonSerializable()
class DeepLinkResultSuccess extends DeepLinkResult {
  const DeepLinkResultSuccess({
    required this.params,
    required this.location,
  });

  final String location;
  final Map<String, dynamic> params;
}

class DeepLinkResultError extends DeepLinkResult {
  const DeepLinkResultError(this.error);

  final Exception error;
}
```

### ECommerce

#### Отправка событий ECommerce UA

```dart
final event = ECommerceUAEvent(
    eventName: eventName,
    customDimensions: {'customParameter5': 23.8},
    ecommerceParameters:{'customecommerceParameters':'value1'},
    ecommerce: ECommerceUAEventName.checkoutOption,
    currencyCode: 'RUB',
  );
mtsAnalyticsPlugin.trackEvent(event);
```

#### Отправка событий ECommerce GA4

```dart
final ecommerceGA4EventItem = ECommerceGA4EventItem(
  itemId: 'id123',
  itemName: 'Watermelon',
  itemListName: 'Fruits',
  itemListId: '123145',
  index: '1',
  itemBrand: 'MyFarmerMarket',
  itemCategory: 'Food',
  itemCategory2: 'Fruits',
  itemCategory3: 'Green',
  itemCategory4: 'Round',
  itemCategory5: '10kg',
  itemVariant: 'Medium',
  affiliation: 'online store',
  discount: '15%',
  coupon: 'SUMMER24',
  price: '230',
  currency: 'RUB',
  quantity: '1',
  creativeName: 'fruit adv',
  creativeSlot: 'top',
  promotionId: '098e',
  promotionName: 'Summer Season',
  customDimensions: {'customParameter1': '1'},
);

final ga4EventItemNullProp = ECommerceGA4EventItem(
  itemId: 'id123',
  itemName: 'Watermelon',
  itemListName: null,
  itemListId: null,
  index: null,
  itemBrand: null,
  itemCategory: null,
  itemCategory2: null,
  itemCategory3: null,
  itemCategory4: null,
  itemCategory5: null,
  itemVariant: null,
  affiliation: null,
  discount: null,
  coupon: null,
  price: null,
  currency: null,
  quantity: null,
  creativeName: null,
  creativeSlot: null,
  promotionId: null,
  promotionName: null,
  customDimensions: {'customParameter1': null},
);

final event = ECommerceGA4Event(
    eventName: eventName,
    transactionId: '1234',
    affiliation: 'online store',
    value: '230',
    currency: 'RUB',
    tax: '10',
    shipping: 'ground',
    shippingTier: '1',
    paymentType: 'credit card',
    coupon: 'SUMMER24',
    itemListName: 'Fruits',
    itemListId: '123145',
    items: [
      ecommerceGA4EventItem,
      ga4EventItemNullProp,
    ],
    creativeName: 'fruit adv',
    creativeSlot: 'top',
    promotionId: '098e',
    promotionName: 'Summer Season',
    customDimensions: {'customParameter2': 2},
  );
mtsAnalyticsPlugin.trackEvent(event);
```

