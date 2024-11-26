/// Product Category
/// Категория продукта. Внедрено для МТС Банка
///
/// Example: karta|telefon
///
/// Свои имена можно отправить через вариант Custom:
/// [PrCat.Custom('internet')]
sealed class ProductCategory {
  final String? value;
  const ProductCategory(this.value);
}

class Nullable extends ProductCategory {
  const Nullable() : super(null);
}

class BankCard extends ProductCategory {
  const BankCard() : super('karta');
}

class Telephone extends ProductCategory {
  const Telephone() : super('telefon');
}

class Custom extends ProductCategory {
  const Custom(String super.value);
}
