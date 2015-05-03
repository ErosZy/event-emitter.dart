library test.event_emitter;

import 'package:test/test.dart';
import 'package:event-emitter/event_emitter.dart';

void main() {
    group('Event emitter', () {
        setUp(() {
            EventEmitter.defaultMaxListeners = 10;
        });

        group('::addListener', () {
            test("should add function-type listener to string-type event if event isn't registered yet", () {
                String eventName = 'event';
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventName, eventHandler);
                expect(emitter.listeners(eventName), equals([eventHandler]));
            });

            test("should add function-type listener to string-type event if such event is already registered", () {
                String eventAName = 'eventA';
                Function eventHandler = () {
                    print('Hello world');
                };

                Function anotherEventHandler = () {
                    print('Hello again');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventAName, eventHandler);
                emitter.addListener(eventAName, anotherEventHandler);
                expect(emitter.listeners(eventAName), equals([eventHandler, anotherEventHandler]));
            });
        });

        group('::on', () {
            test("should add function-type listener to string-type event if event isn't registered yet", () {
                String eventName = 'event';
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.on(eventName, eventHandler);
                expect(emitter.listeners(eventName), equals([eventHandler]));
            });

            test("should add function-type listener to string-type event if such event is already registered", () {
                String eventAName = 'eventA';
                Function eventHandler = () {
                    print('Hello world');
                };

                Function anotherEventHandler = () {
                    print('Hello again');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.on(eventAName, eventHandler);
                emitter.on(eventAName, anotherEventHandler);
                expect(emitter.listeners(eventAName), equals([eventHandler, anotherEventHandler]));
            });
        });

        group('::listeners', () {
            test('should return empty list if none of listeners are added', () {
                EventEmitter emitter = new EventEmitter();
                expect(emitter.listeners('some event'), isEmpty);
            });

            test('should return both listeners and one-time listeners for event', () {
                EventEmitter emitter = new EventEmitter();
                int i = 0;
                emitter.addListener('eventA', () => i++);
                emitter.once('eventA', () => i++);
                expect(emitter.listeners('eventA').length, equals(2));
            });
        });

        group('::removeListener', () {
            test('should remove listener for given event', () {
                String eventName = 'eventA';
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventName, eventHandler);
                emitter.removeListener(eventName, eventHandler);
                expect(emitter.listeners(eventName), isEmpty);
            });

            test("should remove nothing if event does is not registered", () {
                String eventAName = 'eventA';
                String eventBName = 'eventB';
                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventAName, eventHandler);
                emitter.removeListener(eventBName, eventHandler);
                expect(emitter.listeners(eventAName), equals([eventHandler]));
            });

            test("should remove nothing if event has no such listener registered", () {
                String eventAName = 'eventA';

                Function eventHandler = () {
                    print('Hello world');
                };

                Function anotherHandler = () {
                    print('Salut!');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.addListener(eventAName, eventHandler);
                emitter.removeListener(eventAName, anotherHandler);
                expect(emitter.listeners(eventAName), equals([eventHandler]));
            });

            test("should remove one-time event handlers", () {
                String eventName = 'eventA';

                Function eventHandler = () {
                    print('Hello world');
                };

                EventEmitter emitter = new EventEmitter();
                emitter.once(eventName, eventHandler);
                emitter.removeListener(eventName, eventHandler);
                expect(emitter.listeners(eventName), isEmpty);
            });
        });

        group('::removeAllListeners', () {
            test('should remove all listeners for given event if it exists', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener('event', () => print('Hello!'));
                emitter.removeAllListeners('event');

                expect(emitter.listeners('event'), isEmpty);
            });

            test('should remove all listeners if no event name has been passed', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener('eventA', () => print('Hello!'));
                emitter.addListener('eventB', () => print('Salut!'));
                emitter.removeAllListeners();

                expect(emitter.listeners('eventA'), isEmpty);
                expect(emitter.listeners('eventB'), isEmpty);
            });

            test('should remove also one-time events', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener('event', () => print('Hello!'));
                emitter.once('event', () => print('Salut!'));
                emitter.removeAllListeners('event');
                expect(emitter.listeners('event'), isEmpty);
            });
        });

        group('[static]::listenersCount', () {
            test('should return number of listeners for given event', () {
                EventEmitter emitter = new EventEmitter();
                emitter.addListener('event', () => print('Hello world!'));
                expect(EventEmitter.listenerCount(emitter, 'event'), equals(1));
            });

            test('should return 0 if no listners are assigned for given event', () {
                EventEmitter emitter = new EventEmitter();
                expect(EventEmitter.listenerCount(emitter, 'event'), equals(0));
            });
        });

        group('::emit', () {
            test('should execute handler for given event', () {
                EventEmitter emitter = new EventEmitter();
                int i = 1;
                emitter.addListener('event', () => i++);
                emitter.emit('event');
                expect(i, equals(2));
            });

            test('should execute handler with parameters given in a list', () {
                EventEmitter emitter = new EventEmitter();
                int i = 0;
                emitter.addListener('event', (int number) {
                    i = number;
                });
                emitter.emit('event', [2]);
                expect(i, equals(2));
            });
        });

        group('::once', () {
            test('should declare handler that is immediately removed after executing', () {
                EventEmitter emitter = new EventEmitter();
                int i = 0;
                emitter.once('event', () => i++);
                emitter.emit('event');
                expect(i, equals(1));
                expect(emitter.listeners('event'), isEmpty);
            });
        });

        group('event listeners limit', () {
            test('it should not allow to add more event listeners than defaultMaxListeners value', () {
                EventEmitter.defaultMaxListeners = 2;
                EventEmitter emitter = new EventEmitter();
                emitter.addListener('event', () => print('Hello world'));
                expect(() => emitter.addListener('event', () => print('Hello world')), throws);
            });

            test('it should not allow to add more one-time event listeners than defaultMaxListeners value', () {
                EventEmitter.defaultMaxListeners = 2;
                EventEmitter emitter = new EventEmitter();
                emitter.addListener('event', () => print('Hello world'));
                expect(() => emitter.once('event', () => print('Hello world')), throws);
            });

            test('it should allow to override per-instance event listeners limit', () {
                EventEmitter.defaultMaxListeners = 2;
                EventEmitter emitter = new EventEmitter();
                emitter.setMaxListeners(3);
                emitter.addListener('event', () => print('Hello world'));
                expect(() => emitter.addListener('event', () => print('Hello world')), isNot(throws));
                expect(() => emitter.addListener('event', () => print('Hello world')), throws);
            });
        });
    });
}
