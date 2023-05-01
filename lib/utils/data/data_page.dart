import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:loyalty/core/service/event_bus/event_bus.dart';
import 'package:loyalty/core/service/event_bus/events.dart';
import 'package:loyalty/core/service/injection_container.dart';
import 'package:loyalty/ui/components/operation_runner.dart';
import 'package:loyalty/ui/components/overlay/overlay_manager.dart';
import 'package:loyalty/utils/data/data_error.dart';

abstract class DataPage<T extends StatefulWidget> extends OperationRunnerState<T>
    with AutomaticKeepAliveClientMixin {
  bool loaded = false;
  bool loading = true;
  Object? lastError;

  bool get showLoader => true;

  bool get showError => !loading && !loaded && lastError != null;

  bool get isLoadingInitialData => loading && !loaded;

  Future<void> onLoad();
  Future<void> onRefresh();

  Widget buildPage(BuildContext context);

  void refreshChildren() {
    getIt.get<EventBus>().emit(PageReloaded());
  }

  void requestRender() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _loadData() async {
    loading = true;
    requestRender();

    try {
      if (!loaded) {
        if (showLoader) OverlayManager.pageBusy();
        await onLoad();
        loaded = true;
      } else {
        refreshChildren();
        await onRefresh();
      }
      lastError = null;
    } catch (e) {
      lastError = e;
    }

    OverlayManager.pageIdle();

    loading = false;
    requestRender();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FocusDetector(
      child: showError
          ? buildError()
          : isLoadingInitialData
              ? Container(
                  color: Colors.white,
                )
              : buildPage(context),
      onFocusGained: () => _loadData(),
      onFocusLost: () {},
    );
  }

  Widget buildError() => Material(
        color: Colors.white,
        child: Center(
          child: DataError(onRetry: _loadData),
        ),
      );

  @override
  bool get wantKeepAlive => false;
}
