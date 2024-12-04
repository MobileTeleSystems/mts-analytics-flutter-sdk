/// Multi-Account Type.
/// Тип аккаунта в мультиаккаунте, под которым происходят взаимодействия
///
/// Example: null|master|slave
sealed class MultiAccountType {
  final String? value;
  const MultiAccountType(this.value);
}

class Nullable extends MultiAccountType {
  const Nullable() : super(null);
}

class Parent extends MultiAccountType {
  const Parent() : super('master');
}

class Child extends MultiAccountType {
  const Child() : super('slave');
}
