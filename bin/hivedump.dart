import 'dart:io';
import 'package:args/args.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:hivedump/serialize.dart';

void main(List<String> arguments) async {
  final parser = ArgParser();
  ArgResults argResults = parser.parse(arguments);
  final paths = argResults.rest;

  for (final path in paths) {
    if (await FileSystemEntity.isDirectory(path)) {
      stderr.writeln('error: $path is a directory.');
      exitCode = 1;
      return;
    }

    File file = File(path);
    if (!file.existsSync()) {
      stderr.writeln('error: $path does not exist.');
      exitCode = 2;
      return;
    }

    String boxPath = dirname(file.path);
    String boxFileName = basename(file.path);
    String boxName = boxFileName.replaceAll(RegExp(r'\.hive$'), '');

    Hive.init(boxPath);

    var box = await Hive.openBox(boxName);
    Map boxContents = box.toMap();

    stdout.writeln(serialize(boxContents));
  }
}
