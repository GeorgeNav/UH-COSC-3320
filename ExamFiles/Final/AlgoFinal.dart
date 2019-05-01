import 'dart:convert';
import 'data_structures/Tree.dart';
import 'math/MyMath.dart';
import 'dart:io';
import 'dart:math';

main() {
  int input;

  printOptions();
  while(true) {
    stdout.write('Enter your choice: ');
    input = int.parse(stdin.readLineSync());

    switch(input) {
      case 1:
        tree(false);
        printOptions();
        break;
      case 2:
        tree(true);
        printOptions();
        break;
      case 3:
        inverse();
        printOptions();
        break;
      case 0:
        exit(0);
        printOptions();
        break;
      default:
        break;
    }
  }
}

printOptions() {
  print('(1) Search Tree');
  print('(2) AVL Tree');
  print('(3) Inverse');
  print('(0) Exit');
}

tree(bool balanced) {
  int treeChoice = -1;
  int treeDelChoice = -1;
  var custTree = null;
  var custTreeDel = null;

/*   Random rng = Random(); */
  List treeOptions = [
    [5,6,7,8,9,1,2,3,4,0],
    [4,6,7,8,9,0,1,2,3,5],
    [8,1,2,3,5,6,4,7,10,9],
/*     List.generate(10, (_) => rng.nextInt(10)), */
  ];
  List treeDelOptions = [
    [1,8,2,5],
    [5,4,6,1],
    [6,2,8,4],
    [6,2,8,4,5],
    [6,8,2,5,4],
/*     List.generate(4, (_) => rng.nextInt(10)), */
  ];

  for(int i = 0; i < treeOptions.length; i++)
    print('(${i+1}) Insert ' + treeOptions[i].toString() + ' nodes');
  print('(9) Custom nodes to insert');
  print('(0) Exit');
  while(treeChoice < 1 || treeChoice > treeOptions.length) {
    stdout.write('Enter your choice: ');
    treeChoice = int.parse(stdin.readLineSync());
    if(treeChoice == 0)
      return;
    else if(treeChoice == 9) {
      custTree = [];
      print('Enter nodes to insert (seperate each number by a space): ');
      final values1 = stdin.readLineSync().split(' ');
      values1.forEach((item) {
        custTree.add(int.parse(item));
      });
      break;
    }
  }

  for(int i = 0; i < treeDelOptions.length; i++)
    print('(${i+1}) Delete ' + treeDelOptions[i].toString() + ' nodes');
  print('(9) Custom nodes to delete');
  print('(0) Exit');
  while(treeDelChoice < 1 || treeDelChoice > treeDelOptions.length) {
    stdout.write('Enter your choice: ');
    treeDelChoice = int.parse(stdin.readLineSync());
    if(treeDelChoice == 0)
      return;
    else if(treeDelChoice == 9) {
      custTreeDel = [];
      print('Enter nodes to delete (seperate each number by a space): ');
      final values2 = stdin.readLineSync().split(' ');
      values2.forEach((item) {
        custTreeDel.add(int.parse(item));
      });
      break;
    }
  }
  print(custTree);
  print(custTreeDel);
  Tree(
    custTree == null ? treeOptions[treeChoice-1] : custTree,
    custTreeDel == null ? treeDelOptions[treeDelChoice-1] : custTreeDel,
    balanced
  );
}

inverse() {
/*   MyMath()..inverse(65536, 32765); */
  stdout.write('Enter a: ');
  int a = int.parse(stdin.readLineSync());
  stdout.write('Enter b: ');
  int b = int.parse(stdin.readLineSync());
  MyMath()..inverse(a, b);
  // Past Exam Pairs
  //  131072, 32765
  //  131072, 93775
  //  65536, 32765
}
