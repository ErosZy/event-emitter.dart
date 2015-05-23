# DartEventEmitter

[![Build Status](https://travis-ci.org/eps90/event-emitter.dart.svg?branch=master)](https://travis-ci.org/eps90/event-emitter.dart)
[![Coverage Status](https://coveralls.io/repos/eps90/event-emitter.dart/badge.svg?branch=master)](https://coveralls.io/r/eps90/event-emitter.dart?branch=master)

Basic implementation of EventEmitter in Dart - a port of Node.js' [EventEmitter](https://nodejs.org/api/events.html#events_class_events_eventemitter) enhanced with Dart goodness.

## Installation

To install package in your system, declare it as a dependency in `pubspec.yaml`:

```yaml
dependencies:
    dart_event_emitter: ">=1.0.0 <2.0.0"
```

Then import `dart_event_emitter` in your project

```dart
import 'package:dart_event_emitter/dart_event_emitter.dart';
```

## Usage

### As an instance

You can treat `EventEmitter` class as a object holding data about your events:

```dart
class MyAwesomeClass {
    EventEmitter _emitter = new EventEmitter();
    
    MyAwesomeClass() {
        _emitter.on('action', () {
            print 'Action recorded!';
        });
    }
    
    void doAwesomeThings() {
        _emitter.emit('action');
    }
}
```

### As a parent class
You can also decide that your class be responsible for own events:

```dart
class MyAwesomeClass extends EventEmitter {
    MyAwesomeClass() {
        on('action', () {
            print 'Action recorded!';
        });
    }
    
    void doAwesomeThings() {
        emit('action');
    }
}
```

## To be done

* asynchronous event handling with Futures
* register handlers and events with annotations
