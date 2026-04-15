import 'package:envgen/commands/index.dart';
import 'package:envgen/core/index.dart';

class EnvValidateCommand implements BaseCommand {
  @override
  String get name => 'validate';

  @override
  void configure(parser) {}

  @override
  Future<void> execute(args) async {
    Validator.validateAll();
  }
}