import 'package:envgen/commands/index.dart';
import 'package:envgen/core/index.dart';

class InitCommand implements BaseCommand {
  @override
  String get name => 'init';

  @override
  void configure(parser) {}

  @override
  Future<void> execute(args) async {
    Config.init();
    Schema.init();

    Logger.success('Initialized');
  }
}