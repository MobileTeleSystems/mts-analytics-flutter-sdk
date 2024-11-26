sealed class TouchPoint {
  final String value;

  const TouchPoint(this.value);
}

class App extends TouchPoint {
  const App() : super('app');
}

class WebView extends TouchPoint {
  const WebView() : super('webview');
}
