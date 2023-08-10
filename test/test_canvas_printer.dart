import 'dart:io';

import 'package:ansi_escapes/src/ansi_escapes.dart';
import 'package:ansi_escapes/src/constants/constants.dart';

void main() {
  final canvas = StringBuffer();
  var ansiEscapes = AnsiEscapes();

  // TODO: try executing a set of read/write commands INSIDE this process by
  //  calling another process, and/or capturing the contents of its TTY?
  //  There are shell commands to copy/cat the content of TTY (in Unix, it's all files)
  //  so that's the "buffer" we're looking for, maybe?

  // clear canvas
  // canvas.clear();
  stdout.write(ansiEscapes.clearScreen);
  // canvas.write(ansiEscapes.clearScreen);
  // canvas.write(ansiEscapes.clearScreen);

  // stdout.write('new canvas:\n');

  // print canvas
  // canvas.write('....\n');
  // canvas.write('....\n');
  // canvas.write('....\n');
  // canvas.write('....\n');

  stdout.write('....\n');
  stdout.write('....\n');
  stdout.write('....\n');
  stdout.write('....\n');


  // run ansi code
  // canvas.write(ansiEscapes.cursorTo(1,1));
  // canvas.write('\u001B[' '2' 'G');
  // canvas.write(ansiEscapes.clearScreen);
  final x = 0;
  final y = 0;

  final cursorCode = ESC + (y + 1).toString() + ';' + (x + 1).toString() + 'H';
  // print('cursorCode: $cursorCode');
  // canvas.write(cursorCode.toString());
  stdout.write(cursorCode.toString());

  // final ansiOutput = ansiEscapes.cursorTo(1,1);
  // print('ansiOutput:\n');
  // sleep(Duration(seconds: 1));
  // print(ansiOutput);

  // print marker at new cursor position
  // canvas.write('%');
  stdout.write('%');
  // canvas.write('o');

  // move cursor to end

  // output canvas
  // print(canvas);
  // stdout.write(canvas);
  // sleep(Duration(seconds: 2));
}
