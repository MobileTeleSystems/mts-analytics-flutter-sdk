import 'package:flutter/foundation.dart';
import 'dart:convert';

class RemoteConfigValue {
  final dynamic _data;

  RemoteConfigValue(this._data);

  String? get stringValue => _data is String ? _data : null;
  int? get integerValue => int.tryParse(_data);
  bool? get boolValue => bool.tryParse(_data, caseSensitive: false);
  double? get doubleValue => double.tryParse(_data);
  dynamic get jsonValue => _parseJson(_data);

  dynamic _parseJson(dynamic value) {
    if (value is String) {
      try {
        return jsonDecode(value);
      } catch (e) {
        debugPrint('Failed to parse JSON: $e');
        return null;
      }
    }
    return null;
  }
}
