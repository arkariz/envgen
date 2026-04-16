import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class EnvListCommand implements BaseCommand {
  @override
  String get name => 'list';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
    parser.addOption('flavor', abbr: 'f', help: 'Show variables for a specific flavor');
  }

  @override
  Future<void> execute(args) async {
    final flavor = args['flavor'];

    // If flavor is specified, show variables for that flavor only
    if (flavor != null) {
      EnvFile.getEnvKeyPair(flavor).forEach((key, value) => Logger.info('$key=$value'));
      return;
    }
    
    // Otherwise, show variables for all flavors
    for (final flavor in EnvFile.flavors()) {
      Logger.info('--- $flavor ---');
      EnvFile.getEnvKeyPair(flavor).forEach((key, value) => Logger.info('$key=$value'));
    }
  }
}