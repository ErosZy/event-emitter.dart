library test.event_emitter.event_handlers_as_classes;

import 'package:test/test.dart';
import 'package:event-emitter/event_emitter.dart';

class SomeEvent implements EventInterface {
    int i;

    SomeEvent([int this.i = 0]);
}

class SomeListener implements EventHandlerInterface {
    void execute(SomeEvent event) {
        event.i++;
    }
}

void main() {
    group('Event handlers', () {
        group('can add event handler object', () {
            test('by ::addListener', () {
                EventEmitter emitter = new EventEmitter();
                EventHandlerInterface listener = new SomeListener();
                emitter.addListener(SomeEvent, listener);
                expect(emitter.listeners(SomeEvent), equals([listener]));
            });

            test('by ::on', () {
                EventEmitter emitter = new EventEmitter();
                EventHandlerInterface listener = new SomeListener();
                emitter.on(SomeEvent, listener);
                expect(emitter.listeners(SomeEvent), equals([listener]));
            });

            test('by ::once', () {
                EventEmitter emitter = new EventEmitter();
                EventHandlerInterface listener = new SomeListener();
                emitter.once(SomeEvent, listener);
                expect(emitter.listeners(SomeEvent), [listener]);
            });
        });

        group('can execute handlers objects on emit', () {
            test('by simple call', () {
                EventEmitter emitter = new EventEmitter();
                emitter.on(SomeEvent, new SomeListener());
                SomeEvent event = new SomeEvent(1);
                emitter.emit(event);
                expect(event.i, equals(2));
            });

            test('by adding with once', () {
                EventEmitter emitter = new EventEmitter();
                emitter.once(SomeEvent, new SomeListener());
                SomeEvent event = new SomeEvent(1);
                emitter.emit(event);
                expect(event.i, equals(2));
                expect(emitter.listeners(SomeEvent), isEmpty);
            });
        });

    });
}
