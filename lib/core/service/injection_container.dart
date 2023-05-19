import 'package:get_it/get_it.dart';
import 'package:loyalty/core/network/network_event_listener.dart';
import 'package:loyalty/core/network/rest_client_impl.dart';
import 'package:loyalty/core/service/event_bus/event_bus.dart';

final getIt = GetIt.instance;

Future<void> setupService() async {
  // register EventBus
  getIt.registerSingleton(EventBus());
  // final httpClient = HttpClient();

  /// setup network event listener
  final netEventListener = NetworkEventListener(refreshSession: () async {
    return true;
  });

  getIt.registerLazySingleton(() => RestClientImpl(netEventListener.onNetworkError));
}
