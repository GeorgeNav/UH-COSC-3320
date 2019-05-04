import 'dart:core';
import 'dart:io';
import 'package:colorize/colorize.dart';

class MyMath {
  MyMath() {}

  inverse(int a, int b) {
    if(a.gcd(b) != 1)
      return;
/*     var a = aVal > bVal ? aVal : bVal;
    var b = aVal > bVal ? bVal : aVal; */
    var inverse = [
      [a,1,0,0],
      [b,0,1,0]
    ];
    var i = 2;
    while(inverse.last[0] != 0) {
      inverse.add([0,0,0,(inverse[i-2][0]/inverse[i-1][0]).floor()]);
      inverse.last = [
        inverse[i-2][0]-inverse.last[3]*inverse[i-1][0],
        inverse[i-2][1]-inverse.last[3]*inverse[i-1][1],
        inverse[i-2][2]-inverse.last[3]*inverse[i-1][2],
        inverse.last[3]
      ];
      i++;
    }
    print('a\tx\ty\tq');
    for(var row in inverse) {
      for(var element in row)
        stdout.write(element.toString() + '\t');
      print('\n');
    } print('\n');
    var s = inverse[inverse.length-2][1];
    var t = inverse[inverse.length-2][2];
    stdout.write('gcd('); colorRed('a'); stdout.write(', '); colorBlue('b'); stdout.write(')'); stdout.write('= '); colorRed('a'); stdout.write('*s'); stdout.write(' + '); colorBlue('b'); stdout.write('*t = 1\n');
    stdout.write('gcd('); colorRed('$a'); stdout.write(', '); colorBlue('$b'); stdout.write(')'); stdout.write('= '); colorRed('$a'); stdout.write('*($s)'); stdout.write(' + '); colorBlue('$b'); stdout.write('*($t) = ${a*s+b*t}\n\n');
    stdout.write('(s)mod('); colorBlue('b'); stdout.write(') is the multiplicative inverse of '); colorRed('a'); stdout.write(' w.r.t '); colorBlue('b'); stdout.write('\n');
    stdout.write('($s)mod('); colorBlue('$b'); stdout.write(') = ${a.modInverse(b)} is the multiplicative inverse of '); colorRed('$a'); stdout.write(' w.r.t '); colorBlue('$b'); stdout.write('\n\n');
    stdout.write('(t)mod('); colorBlue('b'); stdout.write(') is the multiplicative inverse of '); colorBlue('b'); stdout.write(' w.r.t '); colorRed('a'); stdout.write('\n');
    stdout.write('($t)mod('); colorBlue('$b'); stdout.write(') = ${b.modInverse(a)} is the multiplicative inverse of '); colorBlue('$b'); stdout.write(' w.r.t '); colorRed('$a'); stdout.write('\n\n');
  }
  colorRed(string) => stdout.write(Colorize(string)..apply(Styles.LIGHT_RED));
  colorBlue(string) => stdout.write(Colorize(string)..apply(Styles.LIGHT_BLUE));
}
