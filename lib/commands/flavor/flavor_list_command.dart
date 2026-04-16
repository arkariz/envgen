
import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class FlavorListCommand implements BaseCommand {
  @override
  String get name => 'flavor:list';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    final flavors = Config.getFlavors();

    if (flavors.isEmpty) {
      Logger.error('No flavors found');
      return;
    }

    for (final f in flavors) {
      Logger.info(f);
    }
  }
}