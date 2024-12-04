// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deeplink_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeepLinkResultSuccess _$DeepLinkResultSuccessFromJson(
        Map<String, dynamic> json,) =>
    DeepLinkResultSuccess(
      params: json['params'] as Map<String, dynamic>,
      location: json['location'] as String,
    );

Map<String, dynamic> _$DeepLinkResultSuccessToJson(
        DeepLinkResultSuccess instance,) =>
    <String, dynamic>{
      'location': instance.location,
      'params': instance.params,
    };

DeepLinkResultError _$DeepLinkResultErrorFromJson(Map<String, dynamic> json) =>
    DeepLinkResultError(
      DeepLinkResultError._stringToExceptionFromJson(json['error'] as String),
    );

Map<String, dynamic> _$DeepLinkResultErrorToJson(
        DeepLinkResultError instance,) =>
    <String, dynamic>{
      'error': DeepLinkResultError._exceptionToString(instance.error),
    };
