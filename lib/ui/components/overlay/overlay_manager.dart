import 'package:flutter/material.dart';
import 'package:loyalty/core/service/event_bus/event_bus.dart';
import 'package:loyalty/core/service/event_bus/events.dart';
import 'package:loyalty/core/service/injection_container.dart';
import 'package:loyalty/ui/components/loading_screen.dart';

class OverlayManager extends StatefulWidget {
  const OverlayManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<OverlayManager> createState() => _OverlayManagerState();

  static void pageBusy() {
    getIt.get<EventBus>().emit(PageBusyStateChanged(true));
  }

  static void pageIdle() {
    getIt.get<EventBus>().emit(PageBusyStateChanged(false));
  }
}

class _OverlayManagerState extends State<OverlayManager>
    with SingleTickerProviderStateMixin
    implements EventBusListener {
  bool busy = false;

  EventBus eventBus = getIt<EventBus>();

  Duration get loaderAnimationDuration => const Duration(milliseconds: 120);
  late AnimationController loaderAnimationController;

  @override
  void initState() {
    super.initState();

    loaderAnimationController = AnimationController(
      vsync: this,
      duration: loaderAnimationDuration,
    );

    eventBus.registerListener<PageBusyStateChanged>(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !busy,
      child: Stack(
        children: [
          widget.child,
          if (busy)
            LoaderView(
              controller: loaderAnimationController,
            ),
        ],
      ),
    );
  }

  @override
  onEvent(event) {
    if (event is PageBusyStateChanged) {
      busy = event.busy;
      setState(() {});
    }
  }

  @override
  void dispose() {
    eventBus.unregisterListener<PageBusyStateChanged>(this);

    try {
      loaderAnimationController.dispose();
    } catch (_) {
      //do nothing
    }

    super.dispose();
  }
}
