import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loyalty/app.dart';
import 'package:loyalty/core/service/injection_container.dart';

void main() {
  unawaited(runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupService();
    runApp(const ProviderScope(child: App()));
  }, (error, stack) {
    print(error);
  }));
}
