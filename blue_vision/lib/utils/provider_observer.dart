import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggingProviderObserver extends ProviderObserver {
  const LoggingProviderObserver();

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    assert(() {
      print(
          'provider "${provider.name ?? provider.runtimeType}" failed$error$stackTrace');

      return true;
    }());
  }
}
