part of dart_event_emitter;

/// Built-in event fired when new event is added to [EventEmitter]
class NewListenerEvent implements EventInterface {
    static const NAME = 'newListener';
}
