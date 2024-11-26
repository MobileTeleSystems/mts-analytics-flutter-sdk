sealed class EType {
  final String value;

  const EType(this.value);
}

class Screen extends EType {
  const Screen() : super('screenview');
}

class Error extends EType {
  const Error() : super('error');
}

class Default extends EType {
  const Default() : super('event');
}
