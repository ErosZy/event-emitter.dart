library test.event_emitter;

import 'package:test/test.dart';
import 'package:event-emitter/event_emitter.dart';

void main() {
    group('Event emitter', () {
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
        });
    });
}
