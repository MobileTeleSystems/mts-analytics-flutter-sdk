sealed class EPDT {
  final String? value;
  const EPDT(this.value);
}

class Nullable extends EPDT {
  const Nullable() : super(null);
}

class Delivery extends EPDT {
  const Delivery() : super('dostavka');
}

class Pickup extends EPDT {
  const Pickup() : super('samovyvoz');
}

class Custom extends EPDT {
  const Custom(String super.value);
}
