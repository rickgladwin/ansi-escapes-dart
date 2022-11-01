import 'package:ansi_escapes/ansi_escapes.dart';
import 'package:ansi_escapes/src/ansi_escapes.dart';
import 'package:test/test.dart';


void main() {
  group('ansiEscapes', () {
    test('creates an instance of AnsiEscapes', () {
      final ansiEscapesInstance = ansiEscapes;
      expect(ansiEscapesInstance.runtimeType == AnsiEscapes, true);
    });
  });
}