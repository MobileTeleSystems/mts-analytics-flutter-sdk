extension MapDynamicDynamicX on Map<Object?, Object?> {
  Map<String, dynamic> convertToMapStringDynamic() {
    return map((key, value) {
      final String newKey = key.toString();
      dynamic newValue;

      if (value is Map<Object?, Object?>) {
        newValue = value.convertToMapStringDynamic();
      } else if (value is List) {
        // Обработка списков, если они могут содержать вложенные карты
        newValue = value.map((item) {
          if (item is Map<Object?, Object?>) {
            return item.convertToMapStringDynamic();
          } else {
            return item;
          }
        }).toList();
      } else {
        newValue = value;
      }

      return MapEntry(newKey, newValue);
    });
  }
}
