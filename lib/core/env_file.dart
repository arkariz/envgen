import 'dart:io';

import 'package:envflare_cli/core/index.dart';
import 'package:path/path.dart';

/// Utilities for managing environment files.
///
/// Provides methods to access and manage the .envs directory
/// and individual environment files for different flavors.
class EnvFile {
  /// Creates an empty variable for the given key in all flavor environment files.
  static void createVariablesForFlavors({required String key, String? value}) {
    for (final flavor in flavors()) {
      addVariable(flavor: flavor, key: key, value: value);
    }
  }

  /// Adds or updates a variable in the specified flavor's environment file.
  static void addVariable({required String flavor, required String key, String? value}) {
    final env = parseEnv(_getEnvFile(flavor));
    env[key] = value ?? '';
    writeEnv(_getEnvFile(flavor), env);
  }

  /// Removes a variable from the specified flavor's environment file.
  static void removeVariable(String key) {
    for (final flavor in flavors()) {
      final env = parseEnv(_getEnvFile(flavor));
      env.remove(key);
      writeEnv(_getEnvFile(flavor), env);
    }
  }

  /// Gets the key-value pairs from the environment file of a specific flavor.
  static Map<String, String> getEnvKeyPair(String flavor) {
    return parseEnv(_getEnvFile(flavor));
  }

  /// Deletes the environment file for a specific flavor.
  static void deleteEnvFile(String flavor) {
    final file = _getEnvFile(flavor);
    if (file.existsSync()) file.deleteSync();
  }

  /// Gets the list of all configured flavors.
  static List<String> flavors() => Config.getFlavors();

  /// Gets the environment file for a specific flavor.
  ///
  /// Creates the .envs directory if it doesn't exist.
  static File _getEnvFile(String flavor) {
    _dir();
    return File(join('.envs', '$flavor.env'));
  }

  /// Gets the .envs directory, creating it if it doesn't exist.
  static Directory _dir() {
    final d = Directory('.envs');
    if (!d.existsSync()) d.createSync();
    return d;
  }
}