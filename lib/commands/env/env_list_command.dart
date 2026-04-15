import 'package:envgen/commands/index.dart';
import 'package:envgen/core/index.dart';

class EnvListCommand implements BaseCommand {
  @override
  String get name => 'list';

  @override
  void configure(parser) {
    parser.addOption('flavor', abbr: 'f');
  }

  @override
  Future<void> execute(args) async {
    final flavor = args['flavor'];

    if (flavor != null) {
      parseEnv(EnvFile.file(flavor)).forEach((k, v) => Logger.info('$k=$v'));
      return;
    }

    for (final f in EnvFile.flavors()) {
      Logger.info('--- $f ---');
      parseEnv(EnvFile.file(f)).forEach((k, v) => Logger.info('$k=$v'));
    }
  }
}