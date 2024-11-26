import 'package:json_annotation/json_annotation.dart';

part 'deeplink_result.g.dart';

sealed class DeepLinkResult {
  const DeepLinkResult();

  factory DeepLinkResult.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'success':
        return DeepLinkResultSuccess.fromJson(json);
      case 'error':
        return DeepLinkResultError.fromJson(json);
      default:
        return DeepLinkResultError(Exception('Invalid DeepLinkResult type'));
    }
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class DeepLinkResultSuccess extends DeepLinkResult {
  const DeepLinkResultSuccess({
    required this.params,
    required this.location,
  });

  @JsonKey(name: 'location')
  final String location;

  @JsonKey(name: 'params')
  final Map<String, dynamic> params;

  factory DeepLinkResultSuccess.fromJson(Map<String, dynamic> json) =>
      _$DeepLinkResultSuccessFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeepLinkResultSuccessToJson(this);
}

@JsonSerializable()
class DeepLinkResultError extends DeepLinkResult {
  const DeepLinkResultError(this.error);

  @JsonKey(
    name: 'error',
    fromJson: _stringToExceptionFromJson,
    toJson: _exceptionToString,
  )
  final Exception error;

  factory DeepLinkResultError.fromJson(Map<String, dynamic> json) =>
      _$DeepLinkResultErrorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeepLinkResultErrorToJson(this);

  static Exception _stringToExceptionFromJson(String value) => Exception(value);
  static String _exceptionToString(Exception value) => value.toString();
}
