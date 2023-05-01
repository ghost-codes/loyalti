abstract class EventBusListener {
  void onEvent(dynamic event);
}

class EventBus {
  Map<Type, Set<EventBusListener>> listeners = {};

  void registerListener<T>(EventBusListener listener) {
    if (!listeners.containsKey(T)) listeners[T] = {};

    listeners[T]!.add(listener);
  }

  void unregisterListener<T>(EventBusListener listener) {
    listeners[T]?.remove(listener);
  }

  void emit<T>(T event) {
    if (!listeners.containsKey(T)) return;

    for (final listener in listeners[T]!) {
      try {
        listener.onEvent(event);
      } catch (e) {
        print(e);
      }
    }
  }
}
