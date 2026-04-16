import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class EnvSyncCommand implements BaseCommand {
  @override
  String get name => 'sync';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    final schema = Schema.load();

    for (final f in EnvFile.flavors()) {
      final env = parseEnv(EnvFile.file(f));

      for (final field in schema) {
        env.putIfAbsent(field.key, () => '');
      }

      writeEnv(EnvFile.file(f), env);
    }

    Logger.success('Synced');
  }
}