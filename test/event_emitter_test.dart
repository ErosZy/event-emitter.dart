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
    });
}
