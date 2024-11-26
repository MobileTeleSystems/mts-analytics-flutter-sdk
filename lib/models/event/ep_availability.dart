sealed class EPAvailability {
  final String? value;
  const EPAvailability(this.value);
}

class Nullable extends EPAvailability {
  const Nullable() : super(null);
}

class Available extends EPAvailability {
  const Available() : super('v_nalichii');
}

class NotAvailable extends EPAvailability {
  const NotAvailable() : super('net_v_nalichii');
}

class Soon extends EPAvailability {
  const Soon() : super('skoro_v_prodazhe');
}

class PreOffer extends EPAvailability {
  const PreOffer() : super('predzakaz');
}

class Custom extends EPAvailability {
  const Custom(String super.value);
}
