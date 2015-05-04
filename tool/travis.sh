#!/bin/bash

set -e

dartanalyzer --fatal-warnings lib/dart_event_emitter.dart

pub run test:test

# Install dart_coveralls; gather and send coverage data.
if [ "$REPO_TOKEN" ]; then
  pub global activate dart_coveralls
  pub global run dart_coveralls report \
    --token $REPO_TOKEN \
    --retry 2 \
    --exclude-test-files \
    test/test_all.dart
fi
