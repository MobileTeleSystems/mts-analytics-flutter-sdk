import 'package:json_annotation/json_annotation.dart';

part 'remote_config_status.g.dart';

sealed class RemoteConfigStatus {
  const RemoteConfigStatus();

  factory RemoteConfigStatus.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'success':
        return RemoteConfigStatusSuccess.fromJson(json);
      case 'failure':
        return RemoteConfigStatusFailure.fromJson(json);
      case 'throttled':
        return RemoteConfigStatusThrottled.fromJson(json);
      default:
        return RemoteConfigStatusFailure(
          Exception('Invalid RemoteConfigStatus type'),
        );
    }
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class RemoteConfigStatusSuccess extends RemoteConfigStatus {
  const RemoteConfigStatusSuccess();

  factory RemoteConfigStatusSuccess.fromJson(Map<String, dynamic> json) =>
      _$RemoteConfigStatusSuccessFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoteConfigStatusSuccessToJson(this);
}

@JsonSerializable()
class RemoteConfigStatusThrottled extends RemoteConfigStatus {
  const RemoteConfigStatusThrottled();

  factory RemoteConfigStatusThrottled.fromJson(Map<String, dynamic> json) =>
      _$RemoteConfigStatusThrottledFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoteConfigStatusThrottledToJson(this);
}

@JsonSerializable()
class RemoteConfigStatusFailure extends RemoteConfigStatus {
  const RemoteConfigStatusFailure(this.error);

  @JsonKey(
    name: 'error',
    fromJson: _stringToExceptionFromJson,
    toJson: _exceptionToString,
  )
  final Exception? error;

  factory RemoteConfigStatusFailure.fromJson(Map<String, dynamic> json) =>
      _$RemoteConfigStatusFailureFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoteConfigStatusFailureToJson(this);

  static Exception _stringToExceptionFromJson(String value) => Exception(value);
  static String _exceptionToString(Exception? value) => value?.toString() ?? '';
}
