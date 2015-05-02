library event_emitter;

import './event_emitter_interface.dart';

class EventEmitter implements EventEmitterInterface {
    Map<String, List<Function>> _listeners = {};
    Map<String, List<Function>> _oneTimeListeners = {};
    static int defaultMaxListeners = 10;
    int _maxListeners;

    void addListener(String event, Function listener) {
        if (!_listeners.containsKey(event)) {
            _listeners[event] = [];
        }

        verifyListenersLimit(event);

        _listeners[event].add(listener);
    }

    void on(String event, Function listener) {
        addListener(event, listener);
    }

    void once(String event, Function listener) {
        if (!_oneTimeListeners.containsKey(event)) {
            _oneTimeListeners[event] = [];
        }

        verifyListenersLimit(event);

        _oneTimeListeners[event].add(listener);
    }

    int _getMaxListeners() {
        if (_maxListeners == null) {
            return defaultMaxListeners;
        }

        return _maxListeners;
    }

    void verifyListenersLimit(String event) {
        int nextCount = ++listeners(event).length;
        int maxListeners = _getMaxListeners();

        if (nextCount >= maxListeners) {
            throw new Exception("Max listeners count for event '$event' exceeded. Current limit is set to ${_getMaxListeners()}");
        }
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

    void setMaxListeners(int listenersCount) {
        _maxListeners = listenersCount;
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
