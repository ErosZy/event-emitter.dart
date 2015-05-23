part of dart_event_emitter;

/// Built-in event fired when event listener is removed from [EventEmitter]
class RemoveListenerEvent implements EventInterface {
    static const NAME = 'removeListener';
}
