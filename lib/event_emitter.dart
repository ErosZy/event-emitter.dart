library event_emitter;

import './event_emitter_interface.dart';

class EventEmitter implements EventEmitterInterface {
    Map<String, List<Function>> _listeners = {};
    Map<String, List<Function>> _oneTimeListeners = {};

    void addListener(String event, Function listener) {
        if (!_listeners.containsKey(event)) {
            _listeners[event] = [];
        }

        _listeners[event].add(listener);
    }

    void on(String event, Function listener) {
        addListener(event, listener);
    }

    void once(String event, Function listener) {
        if (!_oneTimeListeners.containsKey(event)) {
            _oneTimeListeners[event] = [];
        }

        _oneTimeListeners[event].add(listener);
    }

    void removeListener(String event, Function listener) {
        if (_listeners.containsKey(event) && _listeners[event].contains(listener)) {
            _listeners[event].remove(listener);
        }

        if (_oneTimeListeners.containsKey(event) && _oneTimeListeners[event].contains(listener)) {
            _oneTimeListeners[event].remove(listener);
        }
    }

    void removeAllListeners([String event]) {
        if (event == null) {
            _listeners.clear();
        } else{
            if (_listeners.containsKey(event)) {
                _listeners[event].clear();
            }

            if (_oneTimeListeners.containsKey(event)) {
                _oneTimeListeners[event].clear();
            }
        }
    }

    void setMaxListeners(int n) {

    }

    List listeners(String event) {
        List result = [];
        if (_listeners.containsKey(event)) {
            result.addAll(_listeners[event]);
        }

        if (_oneTimeListeners.containsKey(event)) {
            result.addAll(_oneTimeListeners[event]);
        }

        return result;
    }

    void emit(String event) {
        if (_listeners.containsKey(event)) {
            _listeners[event].forEach((Function handler) {
                handler();
            });
        }

        if (_oneTimeListeners.containsKey(event)) {
            for (int i = 0; i < _oneTimeListeners[event].length; i++) {
                Function handler = _oneTimeListeners[event][i];
                handler();
                _oneTimeListeners[event].removeAt(i);
            }
        }
    }

    static int listenerCount(EventEmitterInterface emitter, String event) {
        return emitter.listeners(event).length;
    }
}
