import 'dart:io';

import 'package:envflare_cli/core/index.dart';

/// Code generator for envied integration.
///
/// Generates Dart code that integrates with the envied package
/// to provide type-safe access to environment variables.
class EnviedGenerator {
  /// Generates the env.dart file with envied annotations.
  ///
  /// Creates a Dart class that uses envied to load environment variables
  /// for all configured flavors. The generated code provides type-safe
  /// access to environment variables based on the current FLAVOR.
  static void generate() {
    final schema = Schema.load();
    final flavors = EnvFile.flavors();

    if (flavors.isEmpty) {
      throw CliException('No flavors found');
    }

    Directory('lib/env').createSync(recursive: true);

    final file = File('lib/env/env.dart');
    final b = StringBuffer();

    b.writeln("import 'package:envied/envied.dart';");
    b.writeln("part 'env.g.dart';");
    b.writeln();

    // Generate @Envied decorators for each flavor
    for (final flavor in flavors) {
      final className = 'Env${_cap(flavor)}';
      b.writeln("@Envied(path: '.envs/$flavor.env', name: '$className')");
    }

    b.writeln("final class Env {");
    b.writeln("  static const String flavor = String.fromEnvironment('FLAVOR');");
    b.writeln();
    b.writeln("  factory Env() => _instance;");
    b.writeln();
    b.writeln("  static final Env _instance = switch (flavor) {");
    for (final flavor in flavors) {
      b.writeln("    '$flavor' => _Env${_cap(flavor)}(),");
    }
    b.writeln("    _ => _Env${_cap(flavors.first)}(),");
    b.writeln("  };");
    b.writeln();

    // Generate fields
    for (final field in schema) {
      final name = _camel(field.key);
      b.writeln("  @EnviedField(varName: '${field.key}')");
      b.writeln("  final String $name = _instance.$name;");
    }

    b.writeln("}");

    file.writeAsStringSync(b.toString());
  }

  static String _camel(String s) 
    => s.toLowerCase().split('_')
      .fold('', (a, b) => a.isEmpty ? b : a + b[0].toUpperCase() + b.substring(1));

  static String _cap(String s) => s[0].toUpperCase() + s.substring(1);
}