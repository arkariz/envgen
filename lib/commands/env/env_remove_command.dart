import 'dart:io';
import 'package:envgen/commands/index.dart';
import 'package:envgen/core/index.dart';

class EnvRemoveCommand implements BaseCommand {
  @override
  String get name => 'remove';

  @override
  void configure(parser) {}

  @override
  Future<void> execute(args) async {
    if (args.arguments.isEmpty) {
      throw CliException('Usage: envgen remove <KEY>');
    }

    final key = args.arguments.first;

    final schemaFile = File(Schema.path);

    if (schemaFile.existsSync()) {
      final updated = schemaFile.readAsLinesSync()
        ..removeWhere((l) => l.trim() == key);

      schemaFile.writeAsStringSync(updated.join('\n'));
    }

    for (final f in EnvFile.flavors()) {
      final env = parseEnv(EnvFile.file(f));
      env.remove(key);
      writeEnv(EnvFile.file(f), env);
    }

    Logger.success('Removed key: $key');
  }
}