import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mts_analytics_plugin/extensions/extensions.dart';
import 'package:mts_analytics_plugin/linkmanager/linkmanager.dart';
import 'remote_config/remote_config.dart';
import 'package:mts_analytics_plugin/models/mts_analytics_config.dart';
import 'models/event/event.dart';

class MtsAnalyticsPlugin {
  late String pluginVersion;
  final RemoteConfig remoteConfig = RemoteConfig(_methodChannel);

  Future<String> getPluginVersion() async {
    final fileContent = await rootBundle.loadString(
      'packages/mts_analytics_plugin/pubspec.yaml',
    );

    if (fileContent.isNotEmpty) {
      String versionStr = fileContent.substring(
        fileContent.indexOf('version:'),
        fileContent.length,
      );
      versionStr = versionStr.substring(0, versionStr.indexOf('\n'));
      return versionStr
          .substring(versionStr.indexOf(':') + 1, versionStr.length)
          .trim();
    }
    return 'unknown';
  }

  static const MethodChannel _methodChannel =
      MethodChannel('mts_analytics_plugin');

  /// Method to get an Url query parameter, name with value.
  /// Value is the current active sessionId with timestamp: [sessionId].[currentTime]
  ///
  /// [url] Url or base url you are going to open.
  ///
  /// return Session query parameter to concatenate with in-app browser url.
  /// Example: '_ma=1008798411687163870.1687163881292'
  Future<String?> getWebSessionQuery(String url) =>
      _methodChannel.invokeMethod('getWebSessionQuery', {'url': url});

  Future<void> init(MtsAnalyticsConfig config) async {
    pluginVersion = await getPluginVersion();
    return _methodChannel.invokeMethod('init', config.toJson());
  }

  Future<void> updateConfig(MtsAnalyticsConfig config) {
    return _methodChannel.invokeMethod('updateConfig', config.toJson());
  }

  Future<void> trackEvent(Event event) {
    return _methodChannel.invokeMethod('track', event.toJson(pluginVersion));
  }

  /// Send URI to MTS Analytics
  Future<void> trackUri({required Uri uri, Map<String, Object?>? map}) {
    final Map<String, Object?> data = <String, Object?>{};
    map?['ma_flutter_plg_version'] = pluginVersion;
    data['uri'] = uri.toString();
    data['map'] = map;
    return _methodChannel.invokeMethod('trackUri', data);
  }

  Future<void> trackEventWithParameter(String eventName, String key) {
    CustomEvent event =
        CustomEvent(eventName: eventName, customDimensions: {key: ''});
    return _methodChannel.invokeMethod('track', event.toJson(pluginVersion));
  }

  Future<void> trackEventWithKeyValue(
    String eventName,
    String key,
    Object? value,
  ) {
    CustomEvent event =
        CustomEvent(eventName: eventName, customDimensions: {key: value});
    return _methodChannel.invokeMethod('track', event.toJson(pluginVersion));
  }

  Future<void> trackEventName(String eventName) {
    CustomEvent event = CustomEvent(
      eventName: eventName,
    );
    return _methodChannel.invokeMethod('track', event.toJson(pluginVersion));
  }

  Future<void> trackEventWithMap(String eventName, Map<String, Object?> map) {
    CustomEvent event =
        CustomEvent(eventName: eventName, customDimensions: map);
    return _methodChannel.invokeMethod('track', event.toJson(pluginVersion));
  }

  Future<void> sendAuthenticationEvent(String ssoState, String? redirectUrl) {
    return _methodChannel.invokeMethod(
      'sendAuthenticationEvent',
      {'ssoState': ssoState, 'redirectUrl': redirectUrl},
    );
  }

  Future<void> setLocation(double? latitude, double? longitude) {
    return _methodChannel.invokeMethod(
      'setLocation',
      {'latitude': latitude, 'longitude': longitude},
    );
  }

  Future<DeepLinkResult?> resolveLink({required Uri uri}) async {
    final result = await _methodChannel.invokeMapMethod<String, dynamic>(
      'resolveLink',
      {'uri': uri.toString()},
    );

    if (result != null) {
      return DeepLinkResult.fromJson(result.convertToMapStringDynamic());
    } else {
      return null;
    }
  }
}
