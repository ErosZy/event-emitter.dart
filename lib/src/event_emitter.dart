library event_emitter.emitter;

import './event_interface.dart';

typedef void EventHandlerFunction(EventInterface event);

class EventEmitter {
    Map<dynamic, List<Function>> _listeners = {};
    Map<dynamic, List<Function>> _oneTimeListeners = {};
    static int defaultMaxListeners = 10;
    int _maxListeners;

    EventEmitter addListener(event, Function listener) {
        if (!_listeners.containsKey(event)) {
            _listeners[event] = [];
        }

        _verifyListenersLimit(event);
        _listeners[event].add(listener);

        return this;
    }

    EventEmitter on(event, Function listener) {
        return addListener(event, listener);
    }

    EventEmitter once(event, Function listener) {
        if (!_oneTimeListeners.containsKey(event)) {
            _oneTimeListeners[event] = [];
        }

        _verifyListenersLimit(event);
        _oneTimeListeners[event].add(listener);

        return this;
    }

    int _getMaxListeners() {
        if (_maxListeners == null) {
            return defaultMaxListeners;
        }

        return _maxListeners;
    }

    void _verifyListenersLimit(event) {
        int nextCount = ++listeners(event).length;
        int maxListeners = _getMaxListeners();

        if (nextCount >= maxListeners) {
            throw new Exception("Max listeners count for event '$event' exceeded. Current limit is set to ${_getMaxListeners()}");
        }
    }

    EventEmitter removeListener(event, Function listener) {
        if (_listeners.containsKey(event) && _listeners[event].contains(listener)) {
            _listeners[event].remove(listener);
        }

        if (_oneTimeListeners.containsKey(event) && _oneTimeListeners[event].contains(listener)) {
            _oneTimeListeners[event].remove(listener);
        }

        return this;
    }

    EventEmitter removeAllListeners([event]) {
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

        return this;
    }

    EventEmitter setMaxListeners(int listenersCount) {
        _maxListeners = listenersCount;

        return this;
    }

    List listeners(event) {
        List result = [];
        if (_listeners.containsKey(event)) {
            result.addAll(_listeners[event]);
        }

        if (_oneTimeListeners.containsKey(event)) {
            result.addAll(_oneTimeListeners[event]);
        }

        return result;
    }

    bool emit(event) {
        var eventType = event is EventInterface ? event.runtimeType : event;
        bool handlersFound = false;

        if (_listeners.containsKey(eventType)) {
            handlersFound = true;
            _listeners[eventType].forEach((Function handler) {
                _callHandler(handler, event);
            });
        }

        if (_oneTimeListeners.containsKey(eventType)) {
            handlersFound = true;
            for (int i = 0; i < _oneTimeListeners[eventType].length; i++) {
                Function handler = _oneTimeListeners[eventType][i];
                _callHandler(handler, event);
                _oneTimeListeners[eventType].removeAt(i);
            }
        }

        return handlersFound;
    }

    void _callHandler(Function handler, [event]) {
        if (handler is EventHandlerFunction) {
            handler(event);
        } else {
            handler();
        }
    }

    static int listenerCount(EventEmitter emitter, event) {
        return emitter.listeners(event).length;
    }
}
