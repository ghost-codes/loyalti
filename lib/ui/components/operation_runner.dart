import 'package:flutter/material.dart';
import 'package:loyalty/core/error/failure.dart';
import 'package:loyalty/ui/components/dialog/dialog_alert.dart';
import 'package:loyalty/ui/components/overlay/overlay_manager.dart';

typedef Operation<T> = Future<T> Function();
typedef OperationFailureHandler = Future<bool> Function(OperationFailure e);

abstract class OperationRunnerState<S extends StatefulWidget> extends State<S> {
  @protected
  Future<T?> runOperation<T>(
    String name,
    Operation<T> operation, {
    Map<String, dynamic>? props,
    bool showLoader = true,
    OperationFailureHandler? errorHandler,
  }) async {
    T? result;
    try {
      if (showLoader) OverlayManager.pageBusy();

      result = await operation();
    } catch (e) {
      if (showLoader) OverlayManager.pageIdle();

      var message = "$e";

      if (e is OperationFailure) {
        message = e.message;

        if (((await errorHandler?.call(e)) ?? false)) return null;
      }

      if (mounted) await showError(context, message);
    } finally {
      if (showLoader) OverlayManager.pageIdle();
    }

    return result;
  }
}
