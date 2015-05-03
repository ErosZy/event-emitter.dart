library test.event_emitter;

import 'src/event_emitter_test.dart' as event_emitter_test;
import 'src/event_emitter_with_event_objects_test.dart' as event_objects_test;
import 'package:test/test.dart';

void main () {
    group('[Event emitter]', event_emitter_test.main);
    group('[Event emitter with objects]', event_objects_test.main);
}
