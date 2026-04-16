import 'dart:io';

import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class EnvGenerateCommand implements BaseCommand {
  @override
  String get name => 'generate';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    EnviedGenerator.generate();

    final result = await Process.run(
      'dart',
      ['run', 'build_runner', 'build'],
      runInShell: true,
    );

    if (result.exitCode != 0) {
      throw CliException(result.stderr);
    }

    Logger.success('Generated successfully');
  }
}