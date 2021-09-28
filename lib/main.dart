import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app.dart';

final logger = Logger('app');

void main() {
  _setupLogging();
  runApp(const App());
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
