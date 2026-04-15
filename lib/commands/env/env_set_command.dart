import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class EnvSetCommand implements BaseCommand {
  @override
  String get name => 'set';

  @override
  void configure(parser) {
    parser.addOption('flavor', abbr: 'f');
  }

  @override
  Future<void> execute(args) async {
    if (args.arguments.length < 2) {
      throw CliException('Usage: envflare_cli set <KEY> <VALUE>');
    }

    final key = args.arguments[0];
    final value = args.arguments[1];
    final flavor = args['flavor'];

    final flavors = EnvFile.flavors();
    if (flavor != null && !flavors.contains(flavor)) {
      throw CliException('Flavor "$flavor" not found');
    }

    if (flavor != null) {
      final env = parseEnv(EnvFile.file(flavor));
      env[key] = value;
      writeEnv(EnvFile.file(flavor), env);
    } else {
      if (flavors.isEmpty) {
        throw CliException('No flavors configured');
      }

      for (final f in flavors) {
        final env = parseEnv(EnvFile.file(f));
        env[key] = value;
        writeEnv(EnvFile.file(f), env);
      }
    }

    Logger.success('Updated $key');
  }
}