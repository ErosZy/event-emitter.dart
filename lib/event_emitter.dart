library event_emitter;

import './event_emitter_interface.dart';

class EventEmitter implements EventEmitterInterface {
    Map<String, List<Function>> _listeners = {};

    void addListener(String event, Function listener) {
        if (!_listeners.containsKey(event)) {
            _listeners[event] = [];
        }

        _listeners[event].add(listener);
    }

    void on(String event, Function listener) {
        addListener(event, listener);
    }

    void once(event, listener) {

    }

    void removeListener(String event, Function listener) {
        if (_listeners.containsKey(event) && _listeners[event].contains(listener)) {
            _listeners[event].remove(listener);
        }
    }

    void removeAllListeners([String event]) {
        if (event == null) {
            _listeners.clear();
        } else if (_listeners.containsKey(event)) {
            _listeners[event].clear();
        }
    }

    void setMaxListeners(int n) {

    }

    List listeners(String event) {
        if (_listeners.containsKey(event)) {
            return _listeners[event];
        }

        return [];
    }

    void emit(event, [data]) {

    }

    int listenerCount(event) {

    }
}
