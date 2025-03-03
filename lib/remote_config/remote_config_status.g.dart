// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteConfigStatusSuccess _$RemoteConfigStatusSuccessFromJson(
        Map<String, dynamic> json) =>
    RemoteConfigStatusSuccess();

Map<String, dynamic> _$RemoteConfigStatusSuccessToJson(
        RemoteConfigStatusSuccess instance) =>
    <String, dynamic>{};

RemoteConfigStatusThrottled _$RemoteConfigStatusThrottledFromJson(
        Map<String, dynamic> json) =>
    RemoteConfigStatusThrottled();

Map<String, dynamic> _$RemoteConfigStatusThrottledToJson(
        RemoteConfigStatusThrottled instance) =>
    <String, dynamic>{};

RemoteConfigStatusFailure _$RemoteConfigStatusFailureFromJson(
        Map<String, dynamic> json) =>
    RemoteConfigStatusFailure(
      RemoteConfigStatusFailure._stringToExceptionFromJson(
          json['error'] as String),
    );

Map<String, dynamic> _$RemoteConfigStatusFailureToJson(
        RemoteConfigStatusFailure instance) =>
    <String, dynamic>{
      'error': RemoteConfigStatusFailure._exceptionToString(instance.error),
    };
