sealed class EName {
  final String value;

  const EName(this.value);
}

class Screen extends EName {
  const Screen() : super('scrn');
}

class Custom extends EName {
  Custom({String value = 'event'}) : super(value);
}

extension ENameExtension on EName {
  String toEventName() {
    switch (this) {
      case Screen():
        return 'scrn';
      case Custom():
        return value;
    }
  }

  String toEventType() {
    switch (this) {
      case Screen():
        return 'screenview';
      case Custom():
        return 'event';
    }
  }
}
