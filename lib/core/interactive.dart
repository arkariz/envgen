import 'dart:io';

import 'package:envflare_cli/core/cli_exception.dart';
import 'package:envflare_cli/core/logger.dart';

/// Utilities to prompt the user for input when running interactively.
class Interactive {
  static String ask(String message, {String? defaultValue, bool required = true}) {
    final defaultFlavor = defaultValue != null ? ' use default flavor ($defaultValue)' : '';

    while (true) {
      stdout.write('$message :$defaultFlavor ');
      final input = stdin.readLineSync();
      if (input == null) {
        throw CliException('Input was closed.');
      }

      final value = input.trim();
      if (value.isEmpty) {
        if (defaultValue != null) {
          return defaultValue;
        }

        if (!required) {
          return '';
        }

        Logger.warning('Value is required. Please try again.');
        continue;
      }

      return value;
    }
  }

  static String choose(String message, List<String> options, {String? defaultValue}) {
    if (options.isEmpty) {
      throw CliException('No options available for $message');
    }

    if (options.length == 1) {
      return options.first;
    }

    Logger.plain(message);
    for (var i = 0; i < options.length; i++) {
      Logger.plain('  ${i + 1}) ${options[i]}');
    }

    while (true) {
      final selection = ask('Choose an option', defaultValue: defaultValue);
      final index = int.tryParse(selection);

      if (index != null && index > 0 && index <= options.length) {
        return options[index - 1];
      }

      if (options.contains(selection)) {
        return selection;
      }

      Logger.warning('Invalid selection. Enter the number or exact option text.');
    }
  }

  static List<String> askList(String message, {String? separator}) {
    final sep = separator ?? ',';
    final input = ask(message);
    return input
        .split(sep)
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  static bool confirm(String message, {bool defaultValue = true}) {
    final suffix = defaultValue ? ' [Y/n]' : ' [y/N]';
    while (true) {
      stdout.write('$message$suffix: ');
      final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';

      if (input.isEmpty) {
        return defaultValue;
      }

      if (input == 'y' || input == 'yes') {
        return true;
      }

      if (input == 'n' || input == 'no') {
        return false;
      }

      Logger.warning('Please enter y or n');
    }
  }
}
