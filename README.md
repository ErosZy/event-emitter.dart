# EventEmitter.dart

Basic implementation of EventEmitter in Dart.

## Limitations
* `EventEmitter::emit` does not allow (yet!) to pass dynamic number of arguments to handler

## To be done
* Create `EventInterface` to be able to hold data needed to handle event by event listener (removes need to pass dynamic number of arguments to `emit`)
* Create `EventHandlerInterface` to be able to hold handlers in separate classes
* If `EventInterface` is implemented, allow to add listeners not only by string but also by event type
* asynchronous event handling with Futures
* add dart-docs for `EventEmitter` and related
* publish package
* bump up version to 0.1 when points above will be implemented
