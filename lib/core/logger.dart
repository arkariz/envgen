import 'dart:io';

/// Log levels for different types of messages.
enum LogLevel { info, success, warning, error }

/// Logging utilities for envflare_cli.
///
/// Provides methods to log messages with appropriate icons and colors
/// for different log levels.
class Logger {
  /// Logs an informational message.
  static void info(String msg) => _log(msg, LogLevel.info);

  /// Logs a success message.
  static void success(String msg) => _log(msg, LogLevel.success);

  /// Logs a warning message.
  static void warning(String msg) => _log(msg, LogLevel.warning);

  /// Logs an error message.
  static void error(String msg) => _log(msg, LogLevel.error);

  /// Logs a plain message without any formatting or icons.
  static void plain(String msg) => stdout.writeln(msg);

  /// Internal logging method that adds appropriate icons.
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