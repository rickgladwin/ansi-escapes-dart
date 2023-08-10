import 'dart:convert';
import 'dart:io';
import 'package:ansi_escapes/ansi_escapes.dart';
import 'package:ansi_escapes/src/constants/constants.dart';
import 'package:pty/pty.dart';

import 'package:ansi_escapes/src/ansi_escapes.dart';
import 'package:test/test.dart';

final String mainPath = 'test/test_canvas_printer.dart';

void main() {
  group('AnsiEscapes', () {
    group('cursorTo', () {
      test('moves cursor to top left of the screen', () async {
        // start the app in its own process
        final process = await Process.start('dart', [mainPath], runInShell: true);
        final lineStream =
            // process.stdout.transform(const Utf8Decoder(allowMalformed: true));
            process.stdout.transform(const Utf8Decoder());

        // print canvas
        // process.stdin.writeln('...');
        // process.stdin.writeln('...');
        // process.stdin.writeln('...');



        // hit enter in process
        // process.stdin.writeln();
        // print('tty:');
        // process.stdin.write('tty');
        // process.stdin.writeln('tty');

        // read output
        var lineStreamBuffer = StringBuffer();

        await for (var line in lineStream) {
          // print('canvas line:\n${line.toString()}');
          // print(line);
          lineStreamBuffer.write(line);
        }

        print('test canvas (all):');
        var cursor_input = stdin.readLineSync(encoding: utf8);
        var process_output = lineStreamBuffer.toString();
        print(lineStreamBuffer.toString());
        // print('1');
        // print('2');
        // print('3');
        // print('4');
        var cursor_input_2 = stdin.readLineSync(encoding: utf8);
        print('should match:');
        print(KnownGood.cursorToTopLeft);

        // assert match
        expect(1, 1);
        expect(process_output, KnownGood.cursorToTopLeft);
      });
      test('moves cursor to top left of the screen in a pseudoterminal', () async {
        // TODO: this might work if there's a way to have ESC etc. recognized in
        //  the bash pseudoterminal. As it stands, `echo '\e[1;1H'` for example
        //  will work (where \e == ESC) but not an equivalent string with 'ESC' or \x1B
        //  Also works: `echo '\t\t\t%'` prints a '%' 3 tabs right.
        //  Or this works: `echo '\x1B[1;10H%'` or `echo '\x1B[5;20H%'` in ZSH/Warp
        //  but not in bash.
        //  see: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
        //  The trick is using the pseudoterminal as a tty canvas, that is, accessing
        //  its stdin and stdout directly and capturing the pseudoterminal's resulting
        //  display, rather than pseudo-entering bash commands.

        // The string we're looking to generate is similar to:
        // '\x1Bc....\n'
        // '....\n'
        // '....\n'
        // '....\n'
        // '\x1B[1;1H%'

        // TODO: also, some tests may fail realistically, if the terminal in
        //  question doesn't support certain representations of control characters
        //  e.g. \x... works but \u... doesn't

        final pty = PseudoTerminal.start('bash', []);
        pty.write('set -m\n');

        final x = 0;
        final y = 0;
        // final cursorCode = ESC + (y + 1).toString() + ';' + (x + 1).toString() + 'H';
        // final cursorCode = "echo -e '\\x1B[5;20H%%%%%%\t\t##'"; // works
        // final cursorCode = "printf '\\x1B[5;20H%%%%%%'"; // doesn't work
        final cursorCode = "printf '\\033[5;15H%%%%%%'"; // works
        // TODO: build the cursorCode string completely (canvas characters, cursor
        //  moves, test character), and send the whole thing to pty. Capture the
        //  stream output from pty OR do a screen cap somehow on the pty.
        //  Compare to known good.
        // final cursorCode = "echo -e '\\u001B[[5;20H%%%%%%'"; // doesn't work
        pty.write(cursorCode);
        pty.write('\n');
        // pty.write('ls\n');
        pty.out.listen((data) {
          print(data);
        });
        // var canvas_lines = 3;
        // var canvas_rows = 4;
        // var canvas_string = '';
        // while (canvas_lines > 0) {
        //   while (canvas_rows > 0) {
        //     canvas_string = canvas_string + '.';
        //     canvas_rows -= 1;
        //   }
        //   canvas_string = canvas_string + '\n';
        //   canvas_lines -= 1;
        // }
        //   pty.write(canvas_string);
        // pty.write('exit\n');
        // pty.kill();
        print(await pty.exitCode);
      });
    });
  });
}

class CanvasPrinter {

}

class KnownGood {
  static String cursorToTopLeft = '''
%...
....
....
....
''';
}
