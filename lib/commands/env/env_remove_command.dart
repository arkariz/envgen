import 'dart:io';
import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class EnvRemoveCommand implements BaseCommand {
  @override
  String get name => 'remove';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    if (args.arguments.isEmpty) {
      throw CliException('Usage: envflare_cli remove <KEY>');
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