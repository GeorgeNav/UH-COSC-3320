import 'dart:collection';
import 'dart:io';

class TowerOfHanoiGraph {
Node  S = Node('S'),
      D = Node('D'),
      A1 = Node('A1'),
      A2 = Node('A2'),
      A3 = Node('A3');

  TowerOfHanoiGraph(int n) {
    S.next = A1;
    A1.next = A2;
    A2.next = A3;
    A3.next = D;
    D.next = S;

    for(int i = 1; i <= n; i++)
      S.q.add(i);
    H4(S, A1, A2, A3, D, n);
  }

  H4(s, a1, a2, a3, d, n) {
    if(n == 1)
      moveDisk(s, d);
    else if(n >= 2) {
      H3(s, a1, a2, a3, d, n-1);
      moveDisk(s, a2);
      H3(a3, d, s, a1, a2, n-1);
      moveDisk(a2, d);
      H3(a1, a2, a3, d, s, n-1);
    }
  }

  H3(s, a1, a2, a3, d, n) {
    if(n == 1)
      moveDisk(s, a3);
    else if(n >= 2) {
      H4(s, a1, a2, a3, d, n-1);
      moveDisk(s, a3);
      H4(d, s, a1, a2, a3, n-1);
    }
  }

  moveDisk(Node s, Node d) {
    if(s.q.isEmpty) {
      print('empty node!');
      return false;
    } else if(d.q.isNotEmpty && s.q.first > d.q.first) {
      print('cannot place that disk there!');
      return false;
    }
/*     Node temp = s;
    do {
      print('');
      print(temp.pegName + '->' + s.q.first.toString() + '->' + temp.next.pegName);
      if(temp.q.first > s.q.first) {
        print('ERROR: bad move at ' + temp.pegName);
        return false;
      }
      printPegs();
      stdin.readLineSync();
      temp = temp.next;
    } while(temp.next != d); */
    print('\n' + s.pegName + '->' + s.q.first.toString() + '->' + d.pegName);
    d.q.addFirst(s.q.removeFirst());
    printPegs();
    stdin.readLineSync();
    return true;
  }

  printPegs() {
    S.printStack();
    stdout.write('\n\t');
    A1.printStack();
    stdout.write('\n\t\t');
    A2.printStack();
    stdout.write('\n\t');
    A3.printStack();
    stdout.write('\n');
    D.printStack();
  }
}

class Node {
  Node next;
  Queue<int> q;
  String pegName;

  Node(this.pegName) {
    this.next = null;
    this.q = Queue<int>();
  }

  printStack() {
    print('$pegName: ' + q.toList().reversed.toString());
  }

}

main() {
  stdout.write('Enter the amount of disks: ');
  var input = int.parse(stdin.readLineSync());
  TowerOfHanoiGraph(input);
}