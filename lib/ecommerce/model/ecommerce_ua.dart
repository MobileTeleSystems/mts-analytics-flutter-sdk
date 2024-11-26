class ECommerceUA {
  Purchase? purchase;
  Add? add;
  CheckoutOption? checkoutOption;
  Checkout? checkout;
  Refund? refund;
  Remove? remove;
  Click? click;
  Detail? detail;
  Impressions? impressions;
  PromoView? promoView;
  PromoClick? promoClick;

  ECommerceUA({
    this.purchase,
    this.add,
    this.checkoutOption,
    this.checkout,
    this.refund,
    this.remove,
    this.click,
    this.detail,
    this.impressions,
    this.promoView,
    this.promoClick,
  });
}

class Purchase {
  ActionField actionField;
  List<Product> products;

  Purchase({required this.actionField, required this.products});
}

extension PurchaseExtension on Purchase {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class CheckoutOption {
  ActionField actionField;

  CheckoutOption({required this.actionField});
}

extension CheckoutOptionExtension on CheckoutOption {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {'actionField': actionField.toJson()};
    return data;
  }
}

class Add {
  ActionField? actionField;
  List<Product> products;

  Add({this.actionField, required this.products});
}

extension AddExtension on Add {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField?.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class Checkout {
  ActionField? actionField;
  List<Product> products;

  Checkout({this.actionField, required this.products});
}

extension CheckoutExtension on Checkout {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField?.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class Refund {
  ActionField actionField;
  List<Product>? products;

  Refund({required this.actionField, this.products});
}

extension RefundExtension on Refund {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField.toJson(),
      'products': products?.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class Remove {
  ActionField? actionField;
  List<Product> products;

  Remove({this.actionField, required this.products});
}

extension RemoveExtension on Remove {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField?.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class Click {
  ActionField? actionField;
  List<Product> products;

  Click({this.actionField, required this.products});
}

extension ClickExtension on Click {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField?.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class Detail {
  ActionField actionField;
  List<Product> products;

  Detail({required this.actionField, required this.products});
}

extension DetailExtension on Detail {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class Impressions {
  List<Product> products;

  Impressions({required this.products});
}

extension ImpressionsExtension on Impressions {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'products': products.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class PromoView {
  ActionField? actionField;
  List<Promotion> promotions;

  PromoView({this.actionField, required this.promotions});
}

extension PromoViewExtension on PromoView {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField?.toJson(),
      'promotions': promotions.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class PromoClick {
  ActionField? actionField;
  List<Promotion> promotions;

  PromoClick({this.actionField, required this.promotions});
}

extension PromoClickExtension on PromoClick {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'actionField': actionField?.toJson(),
      'promotions': promotions.map((product) => product.toJson()).toList(),
    };
    return data;
  }
}

class ActionField {
  String? id;
  String? affiliation;
  String? revenue;
  String? tax;
  String? shipping;
  String? coupon;
  String? step;
  String? option;
  String? list;
  Map<String, Object?> customDimensions;

  ActionField({
    this.id,
    this.affiliation,
    this.revenue,
    this.tax,
    this.shipping,
    this.coupon,
    this.step,
    this.option,
    this.list,
    this.customDimensions = const {},
  });
}

extension ActionFieldExctension on ActionField {
  Map<String, Object?> toJson() {
    final Map<String, Object?> customData = <String, Object?>{};
    final Map<String, Object?> data = {
      'id': id,
      'affiliation': affiliation,
      'revenue': revenue,
      'tax': tax,
      'shipping': shipping,
      'coupon': coupon,
      'step': step,
      'option': option,
      'list': list,
    };

    customData.addAll(customDimensions);
    data['customData'] = customData;

    return data;
  }
}

class Product {
  String name;
  String id;
  String? price;
  String? brand;
  String? category;
  String? variant;
  String? quantity;
  String? coupon;
  String? list;
  String? position;
  Map<String, Object?> customDimensions;

  Product({
    required this.name,
    required this.id,
    this.price,
    this.brand,
    this.category,
    this.variant,
    this.quantity,
    this.coupon,
    this.list,
    this.position,
    this.customDimensions = const {},
  });
}

extension ProductExtension on Product {
  Map<String, Object?> toJson() {
    final Map<String, Object?> customData = <String, Object?>{};
    final Map<String, Object?> data = {
      'name': name,
      'id': id,
      'price': price,
      'brand': brand,
      'category': category,
      'variant': variant,
      'quantity': quantity,
      'coupon': coupon,
      'list': list,
      'position': position,
    };

    customData.addAll(customDimensions);
    data['customData'] = customData;

    return data;
  }
}

class Promotion {
  String? id;
  String? name;
  String? creative;
  String? position;

  Promotion({
    this.id,
    this.name,
    this.creative,
    this.position,
  });
}

extension PromotionExtension on Promotion {
  Map<String, Object?> toJson() {
    final Map<String, Object?> data = {
      'id': id,
      'name': name,
      'creative': creative,
      'position': position,
    };

    return data;
  }
}
