
import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class FlavorAddCommand implements BaseCommand {
  @override
  String get name => 'flavor:add';

  @override
  void configure(parser) {}

  @override
  Future<void> execute(args) async {
    if (args.arguments.isEmpty) {
      throw CliException('Usage: envflare_cli flavor add <NAME>');
    }

    final name = args.arguments.first;

    final config = Config.load();
    final flavors = List<String>.from(config['flavors'] ?? []);

    if (flavors.contains(name)) {
      throw CliException('Flavor "$name" already exists');
    }

    flavors.add(name);
    config['flavors'] = flavors;
    Config.save(config);

    final schema = Schema.load();
    final env = <String, String>{};

    for (final field in schema) {
      env[field.key] = '';
    }

    writeEnv(EnvFile.file(name), env);

    Logger.success('Flavor added: $name');
  }
}