library test.event_emitter.event_emitter_with_event_objects;

import 'package:test/test.dart';
import 'package:event-emitter/event_emitter.dart';

class SomeEvent implements EventInterface {
    int i;

    SomeEvent([int this.i = 0]);

    String getName() {
        return 'some_event';
    }
}

class AnotherEvent implements EventInterface {
    int i;

    AnotherEvent([int this.i = 0]);

    String getName() {
        return 'another_event';
    }
}

void main() {
    group('Event emitter', () {
        setUp(() {
            EventEmitter.defaultMaxListeners = 10;
        });

        group('::addListener', () {
            test("should add function-type listener to string-type event if event isn't registered yet", () {
                Type someEvent = SomeEvent;
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(someEvent, eventHandler);
                expect(emitter.listeners(someEvent), equals([eventHandler]));
            });

            test("should add function-type listener to string-type event if such event is already registered", () {
                Type eventType = SomeEvent;
                Function eventHandler = () {
                    print('Hello world');
                };

                Function anotherEventHandler = () {
                    print('Hello again');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventType, eventHandler);
                emitter.addListener(eventType, anotherEventHandler);
                expect(emitter.listeners(eventType), equals([eventHandler, anotherEventHandler]));
            });
        });

        group('::on', () {
            test("should add function-type listener to string-type event if event isn't registered yet", () {
                Type eventType = SomeEvent;
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.on(eventType, eventHandler);
                expect(emitter.listeners(eventType), equals([eventHandler]));
            });

            test("should add function-type listener to string-type event if such event is already registered", () {
                Type eventType = SomeEvent;
                Function eventHandler = () {
                    print('Hello world');
                };

                Function anotherEventHandler = () {
                    print('Hello again');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.on(eventType, eventHandler);
                emitter.on(eventType, anotherEventHandler);
                expect(emitter.listeners(eventType), equals([eventHandler, anotherEventHandler]));
            });
        });

        group('::listeners', () {
            test('should return empty list if none of listeners are added', () {
                EventEmitter emitter = new EventEmitter();
                expect(emitter.listeners(SomeEvent), isEmpty);
            });

            test('should return both listeners and one-time listeners for event', () {
                EventEmitter emitter = new EventEmitter();
                int i = 0;
                emitter.addListener(SomeEvent, () => i++);
                emitter.once(SomeEvent, () => i++);
                expect(emitter.listeners(SomeEvent).length, equals(2));
            });
        });

        group('::removeListener', () {
            test('should remove listener for given event', () {
                Type eventType = SomeEvent;
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventType, eventHandler);
                emitter.removeListener(eventType, eventHandler);
                expect(emitter.listeners(eventType), isEmpty);
            });

            test("should remove nothing if event has no such listener registered", () {
                Type eventType = SomeEvent;

                Function eventHandler = () {
                    print('Hello world');
                };

                Function anotherHandler = () {
                    print('Salut!');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventType, eventHandler);
                emitter.removeListener(eventType, anotherHandler);
                expect(emitter.listeners(eventType), equals([eventHandler]));
            });

            test("should remove one-time event handlers", () {
                Type eventType = SomeEvent;

                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.once(eventType, eventHandler);
                emitter.removeListener(eventType, eventHandler);
                expect(emitter.listeners(eventType), isEmpty);
            });
        });

        group('::removeAllListeners', () {
            test('should remove all listeners for given event if it exists', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener(SomeEvent, () => print('Hello!'));
                emitter.removeAllListeners(SomeEvent);

                expect(emitter.listeners(SomeEvent), isEmpty);
            });

            test('should remove all listeners if no event name has been passed', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener(SomeEvent, () => print('Hello!'));
                emitter.addListener(AnotherEvent, () => print('Salut!'));
                emitter.removeAllListeners();

                expect(emitter.listeners(SomeEvent), isEmpty);
                expect(emitter.listeners(AnotherEvent), isEmpty);
            });

            test('should remove also one-time events', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener(SomeEvent, () => print('Hello!'));
                emitter.once(SomeEvent, () => print('Salut!'));
                emitter.removeAllListeners(SomeEvent);
                expect(emitter.listeners(SomeEvent), isEmpty);
            });
        });

        group('[static]::listenersCount', () {
            test('should return number of listeners for given event', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener(SomeEvent, () => print('Hello world!'));
                expect(EventEmitter.listenerCount(emitter, SomeEvent), equals(1));
            });

            test('should return 0 if no listners are assigned for given event', () {
                EventEmitter emitter = new EventEmitter();
                expect(EventEmitter.listenerCount(emitter, SomeEvent), equals(0));
            });
        });

        group('::emit', () {
            test('should execute handler for given event', () {
                EventEmitter emitter = new EventEmitter();
                int i = 1;
                emitter.addListener(SomeEvent, () => i++);
                emitter.emit(new SomeEvent());
                expect(i, equals(2));
            });

            test('should execute handler with event if handler is EventHandlerFunction', () {
                EventEmitter emitter = new EventEmitter();
                int i = 1;
                emitter.addListener(SomeEvent, (SomeEvent event) => i = event.i);
                emitter.emit(new SomeEvent(3));
                expect(i, equals(3));
            });

            test('should execute handler with parameters given in a list', () {
                EventEmitter emitter = new EventEmitter();
                int i = 0;
                emitter.addListener(SomeEvent, (int number) {
                    i = number;
                });
                emitter.emit(new SomeEvent(), [2]);
                expect(i, equals(2));
            });
        });

        group('::once', () {
            test('should declare handler that is immediately removed after executing', () {
                EventEmitter emitter = new EventEmitter();
                int i = 0;
                emitter.once(SomeEvent, () => i++);
                emitter.emit(new SomeEvent());
                expect(i, equals(1));
                expect(emitter.listeners(SomeEvent), isEmpty);
            });
        });

        group('event listeners limit', () {
            test('it should not allow to add more event listeners than defaultMaxListeners value', () {
                EventEmitter.defaultMaxListeners = 2;
                EventEmitter emitter = new EventEmitter();
                emitter.addListener(SomeEvent, () => print('Hello world'));
                expect(() => emitter.addListener(SomeEvent, () => print('Hello world')), throws);
            });

            test('it should not allow to add more one-time event listeners than defaultMaxListeners value', () {
                EventEmitter.defaultMaxListeners = 2;
                EventEmitter emitter = new EventEmitter();
                emitter.addListener(SomeEvent, () => print('Hello world'));
                expect(() => emitter.once(SomeEvent, () => print('Hello world')), throws);
            });

            test('it should allow to override per-instance event listeners limit', () {
                EventEmitter.defaultMaxListeners = 2;
                EventEmitter emitter = new EventEmitter();
                emitter.setMaxListeners(3);
                emitter.addListener(SomeEvent, () => print('Hello world'));
                expect(() => emitter.addListener(SomeEvent, () => print('Hello world')), isNot(throws));
                expect(() => emitter.addListener(SomeEvent, () => print('Hello world')), throws);
            });
        });
    });
}
