library event_emitter.event_handler_interface;

import './event_interface.dart';

abstract class EventHandlerInterface {
    void execute(EventInterface event);
}
