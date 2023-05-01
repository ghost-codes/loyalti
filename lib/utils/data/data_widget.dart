import 'package:flutter/material.dart';
import 'package:loyalty/core/service/event_bus/event_bus.dart';
import 'package:loyalty/core/service/event_bus/events.dart';
import 'package:loyalty/core/service/injection_container.dart';
import 'package:loyalty/ui/components/loading_screen.dart';
import 'package:loyalty/utils/data/data_error.dart';

abstract class DataWidget<T extends StatefulWidget> extends State<T> implements EventBusListener {
  bool loaded = false;
  bool loading = true;
  Object? lastError;

  bool get showLoader => loading && !loaded;
  bool get showError => !loading && !loaded && lastError != null;

  Future<void> onLoad();
  Future<void> onRefresh();
  Widget buildWidget(BuildContext context);

  @override
  void initState() {
    super.initState();
    getIt.get<EventBus>().registerListener<PageReloaded>(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await load();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoader) {
      return buildLoader(context);
    } else if (showError) {
      return buildError(context);
    } else if (!loaded) {
      return const SizedBox.shrink();
    }

    return buildWidget(context);
  }

  Widget buildLoader(BuildContext context) => const Material(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
          child: LoadingScreen(),
        ),
      );

  Widget buildError(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: DataError(onRetry: refresh),
      );

  void requestRender() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> load() async {
    loading = true;
    requestRender();

    try {
      await onLoad();
      lastError = null;
      loaded = true;
    } catch (e) {
      lastError = e;
      // AchieveCore.instance.logger
      //     .error("An error occurred while attempting to load data: $e", trace: st);
    }

    loading = false;
    requestRender();
  }

  Future<void> refresh() async {
    loading = true;
    requestRender();

    try {
      await onRefresh();
      lastError = null;
      loaded = true;
    } catch (e) {
      lastError = e;
    }

    loading = false;
    requestRender();
  }

  @override
  onEvent(event) {
    if (event is PageReloaded) {
      refresh();
    }
  }

  @override
  void dispose() {
    getIt.get<EventBus>().unregisterListener<PageReloaded>(this);
    super.dispose();
  }
}
