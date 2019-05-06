import 'dart:collection';
import 'dart:io';

class TowerOfHanoiGraph {
  Node S = Node('S'), D = Node('D'), A1 = Node('A1'), A2 = Node('A2');

  TowerOfHanoiGraph(int n) {
    S.setPointers(A1, null);
    A1.setPointers(S, A2);
    A2.setPointers(A1, D);
    D.setPointers(null, null);

    for (int i = 1; i <= n; i++)
      S.q.add(i);
    H(S, A1, A2, D, n);
/*     H2(S, A1, A2, n, S, A1); */
  }

  H(s, a1, a2, d, n) {
    if (n == 1)
      moveDisk(s, d);
    else if (n >= 2) {
      H2(s, a1, a2, n - 1, s, a2);
      moveDisk(s, a1);
      H2(s, a1, a2, n - 1, a2, s);
      moveDisk(a1, d);
      H(s, a1, a2, d, n - 1);
    }
  }

  H2(a1, a2, a3, n, s, d) {
    if(n == 1)
      moveDisk(s, d);
    else if (n >= 1) {
      if (s == a1) {
        H2(a1, a2, a3, n - 1, a1, a3);
        moveDisk(a1, a2);
        H2(a1, a2, a3, n - 1, a3, a1);
        moveDisk(a2, a3);
        H2(a1, a2, a3, n - 1, a1, a3);
      } else if (s == a3) {
        H2(a1, a2, a3, n - 1, a3, a1);
        moveDisk(a3, a2);
        H2(a1, a2, a3, n - 1, a1, a3);
        moveDisk(a2, a1);
        H2(a1, a2, a3, n - 1, a3, a1);
      }
    }
  }

  moveDisk(Node s, Node d) {
    if (s.q.isEmpty) {
      print('empty node!');
      return false;
    } else if (d.q.isNotEmpty && s.q.first > d.q.first) {
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
    stdout.write('\n');
    A2.printStack();
    stdout.write('\n\t\t');
    D.printStack();
  }
}

class Node {
  Node next;
  Node prev;
  Queue<int> q;
  String pegName;

  Node(this.pegName) {
    this.next = null;
    this.q = Queue<int>();
  }

  setPointers(Node n, Node p) {
    this.next = n;
    this.prev = p;
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
