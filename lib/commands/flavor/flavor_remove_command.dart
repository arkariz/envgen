import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class FlavorRemoveCommand implements BaseCommand {
  @override
  String get name => 'flavor:remove';

  @override
  void configure(parser) {}

  @override
  Future<void> execute(args) async {
    if (args.arguments.isEmpty) {
      throw CliException('Usage: envflare_cli flavor remove <NAME>');
    }

    final name = args.arguments.first;

    final config = Config.load();
    final flavors = List<String>.from(config['flavors'] ?? []);

    if (!flavors.contains(name)) {
      throw CliException('Flavor "$name" not found');
    }

    flavors.remove(name);
    config['flavors'] = flavors;
    Config.save(config);

    final file = EnvFile.file(name);
    if (file.existsSync()) file.deleteSync();

    Logger.success('Flavor removed: $name');
  }
}