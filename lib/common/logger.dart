import 'dart:developer';

import 'package:logging/logging.dart';

class Log {
  static void init() {
    _initLogger();
  }

  static Logger? _logger;

  static void _initLogger() {
    _logger = Logger('UiLayer');
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      log('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  static void d(String message) {
    _logger?.info(message);
  }

  static void e(String message) {
    _logger?.severe(message);
  }

  static void i(String message) {
    _logger?.info(message);
  }

  static void w(String message) {
    _logger?.warning(message);
  }

  static void v(String message) {
    _logger?.finest(message);
  }
}
