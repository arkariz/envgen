import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class EnvAddCommand implements BaseCommand {
  @override
  String get name => 'add';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    Schema.load();

    if (args.arguments.isEmpty) {
      throw CliException('Usage: envflare_cli add <KEY>');
    }

    final key = args.arguments.first;
    Schema.addKey(key);

    for (final f in EnvFile.flavors()) {
      final env = parseEnv(EnvFile.file(f));
      env[key] = '';
      writeEnv(EnvFile.file(f), env);
    }

    Logger.success('Added key: $key');
  }
}