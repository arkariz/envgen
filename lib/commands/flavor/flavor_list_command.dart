
import 'package:envgen/commands/index.dart';
import 'package:envgen/core/index.dart';

class FlavorListCommand implements BaseCommand {
  @override
  String get name => 'flavor:list';

  @override
  void configure(parser) {}

  @override
  Future<void> execute(args) async {
    final flavors = Config.flavors();

    if (flavors.isEmpty) {
      Logger.error('No flavors found');
      return;
    }

    for (final f in flavors) {
      Logger.info(f);
    }
  }
}