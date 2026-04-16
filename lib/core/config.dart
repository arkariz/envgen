import 'dart:io';
import 'dart:convert';

import 'package:envflare_cli/core/index.dart';

/// Configuration management for envflare_cli.
///
/// Handles loading, saving, and managing the .envflare_cli.json configuration file
/// which contains flavor definitions and other project settings.
class Config {
  /// The path to the configuration file.
  static const path = '.envflare_cli.json';

  /// Loads the configuration from the .envflare_cli.json file.
  ///
  /// Throws [CliException] if the configuration file is missing.
  static Map<String, dynamic> load() {
    final file = File(path);

    if (!file.existsSync()) {
      throw CliException('Missing .envflare_cli.json');
    }

    return jsonDecode(file.readAsStringSync());
  }

  /// Loads the list of configured flavors from the configuration.
  ///
  /// Returns an empty list if no flavors are configured.
  static List<String> getFlavors() {
    final config = load();
    return List<String>.from(config['flavors'] ?? []);
  }

  /// Adds a new flavor to the configuration.
  /// 
  /// Throws [CliException] if the flavor already exists.
  static void addFlavor(String name) {
    if (_isFlavorExists(name)) {
      throw CliException('Flavor "$name" already exists');
    }

    final flavors = getFlavors()..add(name);
    save(flavors);
  }

  /// Removes a flavor from the configuration.
  /// 
  /// Throws [CliException] if the flavor does not exist.
  static void removeFlavor(String name) {
    if (!_isFlavorExists(name)) {
      throw CliException('Flavor "$name" not found');
    }

    final flavors = getFlavors()..remove(name);
    save(flavors);
  }

  /// Saves the configuration to the .envflare_cli.json file.
  ///
  /// The configuration is saved with proper JSON formatting.
  static void save(List<String> flavors) {
    final json = <String, dynamic>{'flavors': flavors};
    File(path).writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(json),
    );
  }

  /// Initializes the configuration file with default values.
  ///
  /// Creates the .envflare_cli.json file if it doesn't exist,
  /// with an empty flavors array.
  static void init() {
    final file = File(path);

    if (!file.existsSync()) {
      file.writeAsStringSync(jsonEncode({
        "flavors": []
      }));
    }
  }

  /// Checks if a flavor with the given name already exists in the configuration.
  ///
  /// Returns true if the flavor exists, false otherwise.
  static bool _isFlavorExists(String name) {
    return getFlavors().contains(name);
  }
}