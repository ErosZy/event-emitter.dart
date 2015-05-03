# EventEmitter.dart
[![Build Status](https://travis-ci.org/eps90/event-emitter.dart.svg?branch=master)](https://travis-ci.org/eps90/event-emitter.dart)
[![Coverage Status](https://coveralls.io/repos/eps90/event-emitter.dart/badge.svg?branch=master)](https://coveralls.io/r/eps90/event-emitter.dart?branch=master)

Basic implementation of EventEmitter in Dart - a port of Node.js' [EventEmitter](https://nodejs.org/api/events.html#events_class_events_eventemitter).

# Installation
To install package in your system, declare it as a dependency:

```yaml
dependencies:
    event_emitter: git://github.com/eps90/event-emitter.dart.git
```

*Note: Pub package is on the way. Look below to see basic roadmap steps.*

When you've got installed `event_emitter`, you can use it however you want:
* as an `EventEmitter` class instance,
* extend your classes with `EventEmitter`,
* use `EventEmitter` as mixin.

## Limitations
* `EventEmitter::emit(String param)` does not allow (yet!) to pass dynamic number of arguments to handler

## To be done
* ~~Create `EventInterface` to be able to hold data needed to handle event by event listener (removes need to pass dynamic number of arguments to `emit`)~~
* ~~If `EventInterface` is implemented, allow to add listeners not only by string but also by event type~~
* Create `EventHandlerInterface` to be able to hold handlers in separate classes
* asynchronous event handling with Futures
* add dart-docs for `EventEmitter` and related
* publish package
* bump up version to 1.0.0 when points above will be implemented
