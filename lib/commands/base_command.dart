import 'package:args/args.dart';

abstract class BaseCommand {
  String get name;

  void configure(ArgParser parser);

  Future<void> execute(ArgResults args);
}