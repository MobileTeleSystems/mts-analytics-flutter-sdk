import 'package:flutter/material.dart';
import 'package:mts_analytics_plugin/ecommerce/ecommerce.dart';
import 'package:mts_analytics_plugin/mts_analytics_plugin.dart';
import 'package:mts_analytics_plugin/models/mts_analytics_config.dart';
import 'package:mts_analytics_plugin/models/log_level.dart';

import 'package:mts_analytics_plugin/models/event/account_type.dart';
import 'package:mts_analytics_plugin/models/event/interaction_type.dart';
import 'package:mts_analytics_plugin/models/event/app_theme.dart';
import 'package:mts_analytics_plugin/models/event/auth_type.dart' as auth_type;
import 'package:mts_analytics_plugin/models/event/button_location.dart'
    as button_location;
import 'package:mts_analytics_plugin/models/event/current_tariff.dart'
    as current_tariff;
import 'package:mts_analytics_plugin/models/event/delivery_type.dart'
    as delivery_type;
import 'package:mts_analytics_plugin/models/event/action.dart' as act;
import 'package:mts_analytics_plugin/models/event/target.dart' as tg;

import 'package:mts_analytics_plugin/models/event/ep_availability.dart'
    as ep_availability;
import 'package:mts_analytics_plugin/models/event/epdt.dart' as epdt;
import 'package:mts_analytics_plugin/models/event/eppl.dart' as eppl;
import 'package:mts_analytics_plugin/models/event/eco.dart' as m_eco;
import 'package:mts_analytics_plugin/models/event/multi_account_type.dart'
    as multi_account_type;
import 'package:mts_analytics_plugin/models/event/payment_type.dart'
    as payment_type;
import 'package:mts_analytics_plugin/models/event/product_category.dart'
    as product_category;
import 'package:mts_analytics_plugin/models/event/touch_point.dart'
    as touch_point;
import 'package:mts_analytics_plugin/models/event/ename.dart' as e_name;
import 'package:mts_analytics_plugin/models/event/event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analytics SDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Analytics SDK Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String url = 'https://mts.ru/';
  String urlWithQuery = '';

  String versionPlugin = 'Version Plugin:';

  MtsAnalyticsPlugin mtsAnalyticsPlugin = MtsAnalyticsPlugin();

  void _incrementCounter() {
    setState(() {
      _counter++;
      MtsAnalyticsPlugin()
          .getWebSessionQuery(url)
          .then((value) => urlWithQuery = url + value.toString());
    });
  }

  void _init() {
    MtsAnalyticsConfig config = MtsAnalyticsConfig()
      ..logLevel = LogLevel.verbose
      ..crashReportingEnabled = false
      ..backgroundTimeout = 120
      ..activeTimeout = 90
      ..eventStorageLimit = 3000
      ..networkTrafficEnabled = true
      ..androidFlowId = 'androidFlowId'
      ..iosFlowId = 'iosFlowId';
    mtsAnalyticsPlugin.init(config);
  }

  void _updateConfig() {
    MtsAnalyticsConfig config = MtsAnalyticsConfig()
      ..logLevel = LogLevel.verbose
      ..crashReportingEnabled = false
      ..backgroundTimeout = 20
      ..activeTimeout = 45
      ..eventStorageLimit = 1500
      ..networkTrafficEnabled = true
      ..androidFlowId = 'androidFlowId'
      ..iosFlowId = 'iosFlowId';
    mtsAnalyticsPlugin.updateConfig(config);
  }

  void _trackMtsEvent() {
    MtsEvent mtsEvent = MtsEvent(
        eventCategory: 'eventCategoryTest',
        eventLabel: 'eventLabelTest',
        eventContent: 'eventContentTest',
        eventContext: 'eventContextTest',
        eventValue: 124,
        interactionType: const NonInteractions(),
        touchPoint: const touch_point.App(),
        buttonLocation: const button_location.TopBar(),
        target: const tg.Banner(),
        action: const act.Play(),
        clientId: 'ebtQL47cHrk',
        mClientId: '93270144851671100000',
        sessionId: '93270144851671100000_1680427772409',
        hitId: '93270144851671100000_1680439999409',
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'userTestId',
        grClientId: '1a2b3c4grClient',
        grId: 'fCj6fvgxypE_20080610152447302',
        aId: 'br7ac10b-55cc-4372-a534-0e02b2c3d479',
        dId: 'd24b5a970278d1d8',
        userAuth: const auth_type.Auth(),
        projectName: '2memory',
        filterName: 'time|single|high|low',
        productName: '2memoryAndroid',
        productId: 'productId',
        funnelName: 'fnl_sales',
        funnelStep: 'fnl_sales_st1',
        formId: 'form1',
        formOrderId: 'formOrderId',
        multiAccountType: const multi_account_type.Parent(),
        accountType: const Fix(),
        bannerName: 'DCM_nabber_cashback',
        bannerId: '4534534',
        region: 'Ufa',
        abName: 'a/b test',
        abVariant: 'a/b test variant',
        currentTariff: const current_tariff.Trial(),
        paymentType: const payment_type.InstallmentPaymentOnline(),
        deliveryType: const delivery_type.Pickup(),
        eventPosition: '23',
        eventProductPromoLabel: const eppl.NotSet(),
        eventProductAvailable: const ep_availability.PreOffer(),
        eventProductDeliveryTerms: const epdt.Pickup(),
        appTheme: const Dark(),
        eco: const m_eco.Payments(),
        profileType: 'employee',
        productCategory: const product_category.BankCard(),
        appsflyerId: '1661431768043-2213402944332562490',
        screenName: 'MainActivity',
        eventName: e_name.Custom(value: 'test'),
        customDimensions: {
          'customParameter': '1',
          'customParameter2': 1,
          'customParameter3': 1.123123124,
          'customParameter4': true,
          'customParameter5': null,
          'customParameter6': [1, '1', null, true, 1.1],
          'customParameter7': {
            'customParameter': '1',
            'customParameter2': 1,
            'customParameter3': 1.123123124,
            'customParameter4': true,
            'customParameter5': null,
          }
        });

    mtsAnalyticsPlugin.trackEvent(mtsEvent);
  }

  void _trackECommerceGA4Event() {
    final ECommerceGA4EventItem item = ECommerceGA4EventItem(
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
        customDimensions: {'customParameter1': '1'});

    final ECommerceGA4Event ecomEvent = ECommerceGA4Event(
        eventName: ECommerceGA4EventName.purchase,
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
        items: [item, item],
        creativeName: 'fruit adv',
        creativeSlot: 'top',
        promotionId: '098e',
        promotionName: 'Summer Season',
        customDimensions: {'customParameter2': 2});

    mtsAnalyticsPlugin.trackEvent(ecomEvent);
  }

  void _trackECommerceUAEvent() {
    final ActionField actionField = ActionField(
        id: '12',
        affiliation: 'Online Store',
        revenue: '10000',
        tax: '1200',
        shipping: 'ground',
        coupon: 'SUMMER24',
        step: '3',
        option: 'card',
        list: 'hats',
        customDimensions: {'customParameter1': 1});

    final Product product = Product(
        name: 'Kangool',
        id: '12',
        price: '10000',
        category: 'hats',
        variant: 'black',
        quantity: '1',
        coupon: 'coupon',
        list: 'clothes',
        position: '2',
        customDimensions: {'customParameter2': 2});

    final Promotion promotion = Promotion(
        id: 'id12e', name: 'adverts 2024', creative: '34342', position: 'top');

    final Purchase purchase =
        Purchase(actionField: actionField, products: [product, product]);
    final Add add = Add(actionField: actionField, products: [product]);
    final CheckoutOption checkoutOption =
        CheckoutOption(actionField: actionField);
    final Checkout checkout = Checkout(products: [product]);
    final Refund refund = Refund(actionField: actionField);
    final Remove remove = Remove(actionField: actionField, products: [product]);
    final Click click = Click(products: [product], actionField: actionField);
    final Impressions impressions = Impressions(products: [product]);
    final Detail detail = Detail(actionField: actionField, products: [product]);
    final PromoClick promoClick =
        PromoClick(promotions: [promotion], actionField: actionField);
    final PromoView promoView =
        PromoView(promotions: [promotion], actionField: actionField);

    final ECommerceUA eCommerceUA = ECommerceUA(
        purchase: purchase,
        add: add,
        checkoutOption: checkoutOption,
        checkout: checkout,
        refund: refund,
        remove: remove,
        click: click,
        detail: detail,
        impressions: impressions,
        promoView: promoView,
        promoClick: promoClick);

    final ECommerceUAEvent eCommerceUAEvent = ECommerceUAEvent(
        eventName: ECommerceUAEventName.click,
        customDimensions: {'customParameter5': 23.8},
        ecommerce: eCommerceUA,
        currencyCode: 'RUB');

    mtsAnalyticsPlugin.trackEvent(eCommerceUAEvent);
  }

  void _trackScreenEvent() {
    final ScreenEvent event =
        ScreenEvent(screenName: 'MainActivityScreen', customDimensions: {
      'customParameter': '1',
      'customParameter2': 1,
      'customParameter3': 1.123123124,
      'customParameter4': true,
      'customParameter5': null,
      'customParameter6': [1, '1', null, true, 1.1],
      'customParameter7': {
        'customParameter': '1',
        'customParameter2': 1,
        'customParameter3': 1.123123124,
        'customParameter4': true,
        'customParameter5': null,
      }
    });

    mtsAnalyticsPlugin.trackEvent(event);
  }

  void _trackCustomEvent() {
    final CustomEvent event = CustomEvent(
        eventName: 'bottomNavigationClick',
        screenName: 'MainActivityScreen',
        customDimensions: {
          'customParameter': '1',
          'customParameter2': 1,
          'customParameter3': 1.123123124,
          'customParameter4': true,
          'customParameter5': null,
          'customParameter6': [1, '1', null, true, 1.1],
          'customParameter7': {
            'customParameter': '1',
            'customParameter2': 1,
            'customParameter3': 1.123123124,
            'customParameter4': true,
            'customParameter5': null,
          }
        });

    mtsAnalyticsPlugin.trackEvent(event);
  }

  void _trackEventOnlyEventName() {
    String key = 'testKey';
    mtsAnalyticsPlugin.trackEventName(key);
  }

  //not work
  void _trackEventWithParameter() {
    String eventName = 'bottomNavigationClick';
    String key = 'testKey';
    mtsAnalyticsPlugin.trackEventWithParameter(eventName, key);
  }

  //not work
  void _trackEventWithKeyValue() {
    String eventName = 'bottomNavigationClick';
    String key = 'testKey';
    String value = 'testValue';
    mtsAnalyticsPlugin.trackEventWithKeyValue(eventName, key, value);
  }

  void _trackEventWithMap() {
    String eventName = 'music_play';
    Map<String, Object?> map = {
      'userId': '3df0-fsd3-sdfd-cvfv',
      'isPayment': true.toString(),
      'userType': 'admin'
    };
    mtsAnalyticsPlugin.trackEventWithMap(eventName, map);
  }

  void _setLocation() {
    double latitude = 55.75;
    double longitude = 37.6167;
    mtsAnalyticsPlugin.setLocation(latitude, longitude);
  }

  void _sendAuthenticationEvent() {
    String ssoState = '234234111';
    String redirectUrl = 'https://client-analytics.mts.ru/api/mts-sso/callback';
    mtsAnalyticsPlugin.sendAuthenticationEvent(ssoState, redirectUrl);
  }

  void _getVersionPlugin() {
    String? version = mtsAnalyticsPlugin.pluginVersion;
    setState(() {
      versionPlugin = 'versionPlugin: $version';
    });
  }

  void _getCrash() {
    List items = [1, 2, 3, 4, 5, 6];
    items[1000] = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_counter.toString()),
              Text(
                urlWithQuery,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: _init,
                child: Text('Init'),
              ),
              TextButton(
                onPressed: _updateConfig,
                child: Text('UpdateConfig'),
              ),
              TextButton(
                onPressed: _trackMtsEvent,
                child: Text('Track mtsEvent'),
              ),
              TextButton(
                onPressed: _trackECommerceGA4Event,
                child: Text('Track ECommerceGA4Event'),
              ),
              TextButton(
                onPressed: _trackECommerceUAEvent,
                child: Text('Track ECommerceUAEvent'),
              ),
              TextButton(
                onPressed: _trackCustomEvent,
                child: Text('Track customEvent'),
              ),
              TextButton(
                onPressed: _trackScreenEvent,
                child: Text('Track screenEvent'),
              ),
              TextButton(
                onPressed: _trackEventOnlyEventName,
                child: Text('Track eventName'),
              ),
              TextButton(
                onPressed: _trackEventWithParameter,
                child: Text('Track event with parameter'),
              ),
              TextButton(
                onPressed: _trackEventWithKeyValue,
                child: Text('Track key value'),
              ),
              TextButton(
                onPressed: _trackEventWithMap,
                child: Text('Track map'),
              ),
              TextButton(
                onPressed: _sendAuthenticationEvent,
                child: Text('sendAuthenticationEvent'),
              ),
              TextButton(
                onPressed: _setLocation,
                child: Text('setLocation'),
              ),
              TextButton(
                onPressed: _getVersionPlugin,
                child: Text(versionPlugin),
              ),
              TextButton(
                onPressed: _getCrash,
                child: Text('crash'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
