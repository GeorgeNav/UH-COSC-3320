import 'dart:collection';
import 'dart:io';

class TowerOfHanoiGraph {
Node  S = Node('S'),
      A1 = Node('A1'),
      A2 = Node('A2'),
      D = Node('D'),
      A3 = Node('A3');

  TowerOfHanoiGraph(int n) {
    S.next = A1;
    A1.next = A2;
    A2.next = D;
    D.next = A3;
    A3.next = A1;

    for(int i = 1; i <= n; i++)
      S.q.add(i);
    H(S, A1, A2, D, A3, n);

/*     for(int i = 1; i <= n; i++)
      A1.q.add(i);
    H2(A1, A2, D, A3, n); */
  }

  H(s, a1, a2, d, a3, n) {
    if(n == 1)
      moveDisk(s, d);
    else if(n >= 2) {
      H(s, a1, a2, d, a3, n-1);
      moveDisk(s, a2);
      H2(d, a3, a1, a2, n-1);
      moveDisk(a2, d);
      H2(a1, a2, d, a3, n-1);
    }
  }

  H2(s, a1, a2, d, n) {
    if(n == 1)
      moveDisk(s, a2);
    else if(n >= 2) {
      H3(s, a1, a2, d, n-1);
      moveDisk(s, a2);
      H3(d, s, a1, a2, n-1);
    }
  }

  H3(s, a1, a2, d, n) {
    if(n == 1)
      moveDisk(s, d);
    else if(n >= 2) {
      H3(s, a1, a2, d, n-1);
      moveDisk(s, a2);
      H2(d, s, a1, a2, n-1);
      moveDisk(a2, d);
      H2(a1, a2, d, s, n-1);
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
/*     stdin.readLineSync(); */
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
    stdout.write('\n\t\t');
    D.printStack();
    stdout.write('\n\t');
    A3.printStack();
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