sealed class EPPL {
  final String? value;
  const EPPL(this.value);
}

class Nullable extends EPPL {
  const Nullable() : super(null);
}

class NotSet extends EPPL {
  const NotSet() : super('(not_set)');
}

class Custom extends EPPL {
  const Custom(String super.value);
}
