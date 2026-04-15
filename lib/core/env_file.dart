import 'dart:io';

import 'package:envflare_cli/core/index.dart';
import 'package:path/path.dart';

/// Utilities for managing environment files.
///
/// Provides methods to access and manage the .envs directory
/// and individual environment files for different flavors.
class EnvFile {
  /// Gets the .envs directory, creating it if it doesn't exist.
  static Directory dir() {
    final d = Directory('.envs');
    if (!d.existsSync()) d.createSync();
    return d;
  }

  /// Gets the environment file for a specific flavor.
  ///
  /// Creates the .envs directory if it doesn't exist.
  static File file(String flavor) {
    dir();
  /// Gets the list of all configured flavors.
    return File(join('.envs', '$flavor.env'));
  }

  static List<String> flavors() => Config.flavors();
}