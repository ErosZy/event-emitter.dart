library event_emitter;

import './event_emitter_interface.dart';

class EventEmitter implements EventEmitterInterface {
    Map<String, List> _listeners = {};

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

    void removeListener(event, listener)
    {

    }

    void removeAllListeners(event, listener) {

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
