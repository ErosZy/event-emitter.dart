# DartEventEmitter.dart

[![Build Status](https://travis-ci.org/eps90/event-emitter.dart.svg?branch=master)](https://travis-ci.org/eps90/event-emitter.dart)
[![Coverage Status](https://coveralls.io/repos/eps90/event-emitter.dart/badge.svg?branch=master)](https://coveralls.io/r/eps90/event-emitter.dart?branch=master)

Basic implementation of EventEmitter in Dart - a port of Node.js' [EventEmitter](https://nodejs.org/api/events.html#events_class_events_eventemitter) enhanced with Dart goodness.

# Installation

To install package in your system, declare it as a dependency:

```yaml
dependencies:
    dart_event_emitter: ">=1.0.0 <2.0.0"
```

When you've got installed `dart_event_emitter`, you can use it however you want:

* as an `EventEmitter` class instance,
* extend your classes with `EventEmitter`,
* use `EventEmitter` as mixin.

## To be done

* asynchronous event handling with Futures
* register handlers and events with annotations
