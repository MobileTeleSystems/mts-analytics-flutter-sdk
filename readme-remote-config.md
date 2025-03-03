# MTS Analytics SDK

## Remote config

### О Remote config

Remote config — это механизм, позволяющий настроить поведение приложения без необходимости
изменения кода и публикации приложения. Настройки хранятся на сервере и загружаются
при запуске приложения. Также можно задать дефолтные настройки, которые будут храниться локально. Настройки на сервере
нельзя изменить из приложения, только из консоли администратора.

[В начало](#mts-analytics-sdk)

### Инициализация

Проинициализируйте Remote Config

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);
```

[В начало](#mts-analytics-sdk)

### Установка значений по умолчанию

Задайте значения по умолчанию для параметров конфигурации. Это обеспечит работу приложения до получения remote config с сервера.

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);

mtsAnalyticsPlugin.remoteConfig.setDefaultsMap({
                    'key1': 'true',
                    'key2': 'blue',
                    'key3': '13.40',
                    'key4': '100',
                    'key5': '{ "childKey": "child value"}',
                  });
```

[В начало](#mts-analytics-sdk)

### Настройка параметров запросов

Настройка параметров запросов

#### Fetch interval

Минимальный интервал `minFetchInterval` (в секундах) между последовательными запросами к серверу.
Используйте для предотвращения частых запросов. Значение по умолчанию: 300

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);
mtsAnalyticsPlugin.remoteConfig.setMinFetchInterval(300);
```

[В начало](#mts-analytics-sdk)

### Получение и активация значений с сервера

Чтобы получить обновленные значения с сервера, вызовите метод fetchRemoteConfigValues. После успешного получения активируйте их с помощью метода activate().

#### Получение конфига

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);
mtsAnalyticsPlugin.remoteConfig.fetchRemoteConfigValues();
mtsAnalyticsPlugin.remoteConfig.activate();
```

#### Получение и активация

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);
mtsAnalyticsPlugin.remoteConfig.fetchRemoteConfigValuesAndActivate();
```

[В начало](#mts-analytics-sdk)

#### Получение значений после активации

После успешной активации полученные значения будут доступны через метод `configValue(String key)`.

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);
mtsAnalyticsPlugin.remoteConfig.fetchRemoteConfigValuesAndActivate();
final result = mtsAnalyticsPlugin.remoteConfig.configValue('date');
```

[В начало](#mts-analytics-sdk)

### Получение значений по умолчанию

Если вам нужно получить значение по умолчанию, используйте поле `defaultValue(String key)`:

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
final mtsAnalyticsPlugin = MtsAnalyticsPlugin();
mtsAnalyticsPlugin.init(config);
mtsAnalyticsPlugin.remoteConfig.init(config);
mtsAnalyticsPlugin.remoteConfig.fetchRemoteConfigValuesAndActivate();
final result = mtsAnalyticsPlugin.remoteConfig.defaultValue('date');
```

## Лицензия

[![LICENSE](LICENSE.md)

[В начало](#mts-analytics-sdk)
