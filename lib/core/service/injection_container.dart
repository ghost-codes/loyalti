import 'package:get_it/get_it.dart';
import 'package:loyalty/core/service/event_bus/event_bus.dart';

final getIt = GetIt.instance;

Future<void> setupService() async {
  // register EventBus
  getIt.registerSingleton(EventBus());
}
