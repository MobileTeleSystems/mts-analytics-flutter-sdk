import 'package:flutter/services.dart';
import 'package:mts_analytics_plugin/models/mts_analytics_config.dart';
import 'remote_config.dart';
import 'package:mts_analytics_plugin/extensions/extensions.dart';

class RemoteConfig {
  final MethodChannel _methodChannel;

  RemoteConfig(this._methodChannel);

  Future<void> init(MtsAnalyticsConfig config) async {
    return _methodChannel.invokeMethod('rc.init', config.toJson());
  }

  Future<void> setDefaultsMap(Map<String, String> map) {
    return _methodChannel
        .invokeMethod(RemoteConfigMethod.setDefaultsMap.value, {
      'parameters': map,
    });
  }

  Future<RemoteConfigStatus> fetchRemoteConfigValues() async {
    final result = await _methodChannel.invokeMapMethod<String, dynamic>(
      RemoteConfigMethod.fetchRemoteConfigValues.value,
    );
    if (result != null) {
      return RemoteConfigStatus.fromJson(result.convertToMapStringDynamic());
    }
    return RemoteConfigStatusFailure(
      Exception('Failed to fetch remote config'),
    );
  }

  Future<void> activate() {
    return _methodChannel.invokeMethod(RemoteConfigMethod.activate.value);
  }

  Future<RemoteConfigStatus> fetchRemoteConfigValuesAndActivate() async {
    final result = await _methodChannel.invokeMapMethod<String, dynamic>(
      RemoteConfigMethod.fetchRemoteConfigValuesAndActivate.value,
    );
    if (result != null) {
      return RemoteConfigStatus.fromJson(result.convertToMapStringDynamic());
    }
    return RemoteConfigStatusFailure(
      Exception('Failed to fetch and activate remote config'),
    );
  }

  Future<RemoteConfigValue?> configValue(String key) async {
    final result = await _methodChannel.invokeMethod(
      RemoteConfigMethod.getConfigValue.value,
      {
        'key': key,
      },
    );
    if (result != null) {
      return RemoteConfigValue(result);
    } else {
      return null;
    }
  }

  Future<RemoteConfigValue?> defaultValue(String key) async {
    final result = await _methodChannel.invokeMethod(
      RemoteConfigMethod.getDefaultConfigValue.value,
      {
        'key': key,
      },
    );
    if (result != null) {
      return RemoteConfigValue(result);
    } else {
      return null;
    }
  }

  Future<void> setMinFetchInterval(int interval) {
    return _methodChannel.invokeMethod('rc.minFetchInterval', {
      'interval': interval,
    });
  }
}
