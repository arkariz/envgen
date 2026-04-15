import 'dart:io';

enum LogLevel { info, success, warning, error }

class Logger {
  static void info(String msg) => _log(msg, LogLevel.info);
  static void success(String msg) => _log(msg, LogLevel.success);
  static void warning(String msg) => _log(msg, LogLevel.warning);
  static void error(String msg) => _log(msg, LogLevel.error);

  static void _log(String msg, LogLevel level) {
    final icon = switch (level) {
      LogLevel.info => 'ℹ️',
      LogLevel.success => '✅',
      LogLevel.warning => '⚠️',
      LogLevel.error => '❌',
    };

    stdout.writeln('$icon $msg');
  }
}