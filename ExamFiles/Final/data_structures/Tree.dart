import 'dart:core';
import 'dart:math';
import "dart:io";
import 'package:colorize/colorize.dart';

class Tree {
  Node root;
  bool balanced;

  Tree(treeList, treeDelList, this.balanced) {
    print(treeList);
    printLine(Styles.LIGHT_GREEN);
    for(var l in treeList) {
      print(Colorize('Inserting ${l}')..lightGreen());
      insert(this.root, Node(l));
      printSubtreeToConsole(this.root);
      printLine(Styles.LIGHT_GREEN);
      stdin.readLineSync();
    }
    printLine(Styles.LIGHT_RED);
    for(var l in treeDelList) {
      print(Colorize('Deleting ${l}')..lightRed());
      delete(this.root, l);
      printSubtreeToConsole(this.root);
      printLine(Styles.LIGHT_RED);
      stdin.readLineSync();
    }
    printSubtreeToConsole(this.root);
  }

  insert(Node root, Node node) {
    if(root == null) {
      this.root = node;
    } else if(root != null) {
      if(node.data < root.data) {
        if(root.left == null) {
          root.left = node;
          node.parent = root;
          updateUpwards(node);
        } else
          insert(root.left, node);
      } else if(node.data >= root.data) { // TODO: figure out the right implementation
        if(root.right == null) {
          root.right = node;
          node.parent = root;
          updateUpwards(node);
        } else
          insert(root.right, node);
      }
    }
  }

  delete(Node node, data) {
    if(node != null) {
      if(node.data > data)
        delete(node.left, data);
      else if(node.data < data)
        delete(node.right, data);
      else if(node.data == data) {
        Node whereToUpdateUpwards;
        if(node.left != null && node.right != null) {
          Node replacementNode = treeHeight(node.left) >= treeHeight(node.right) ?
            getLeftTreeGreatest(node.left) : getRightTreeLeast(node.right);
          print('Replacing ${node.data} with ${replacementNode.data}');
          node.data = replacementNode.data;
          delete(replacementNode, replacementNode.data);
        } else if(node.left != null && node.right == null) {
          Node parent = node.parent;
          if(node != this.root) {
            parent.left == node ?
              parent.left = node.left :
              parent.right = node.left;
            node.left.parent = parent;
            whereToUpdateUpwards = parent;
          } else {
            this.root = node.left;
            node.left.parent = null;
            whereToUpdateUpwards = null; // don't need to update
          }
          node = null;
        } else if(node.left == null && node.right != null) {
          Node parent = node.parent;
          if(node != this.root) {
            parent.left == node ?
              parent.left = node.right :
              parent.right = node.right;
            node.right.parent = parent;
            whereToUpdateUpwards = parent;
          } else {
            this.root = node.right;
            node.right.parent = null;
            whereToUpdateUpwards = null; // don't need to update
          }
          node = null;
        } else {
          Node parent = node.parent;
          if(node != this.root) {
            parent.left == node ?
              parent.left = null :
              parent.right = null;
            whereToUpdateUpwards = parent; // don't need to update
          } else {
            this.root = null;
            whereToUpdateUpwards = null; // don't need to update
          }
          node = null;
        }
        updateBalanceAndDepth(whereToUpdateUpwards);
        updateUpwards(whereToUpdateUpwards);
      }
    }
  }

  getLeftTreeGreatest(Node node) {
    if(node.right == null)
      return node;
    return getLeftTreeGreatest(node.right);
  }

  getRightTreeLeast(Node node) {
    if(node.left == null)
      return node;
    return getRightTreeLeast(node.left);
  }

  rebalance(Node node) {
    // print('problem! balance of ${node.data}: ${node.balance}');
    if(node.balance == 2) {
      node.left.balance = treeHeight(node.left.left) - treeHeight(node.left.right);
      // print('node ${node.left.data}: ${node.left.balance}');
      printSubtreeToConsole(node);
      if(node.left.balance == -1) {// LR rotation
        stdout.write(Colorize('L')..apply(Styles.LIGHT_BLUE));
        stdout.write('(' + node.left.data.toString() + ')');
        stdout.write(Colorize('R')..apply(Styles.LIGHT_MAGENTA));
        print('(' + node.data.toString() + ') Rotation');
        leftRotation(node.left);
        rightRotation(node);
      } else {
        stdout.write(Colorize('R')..apply(Styles.LIGHT_MAGENTA));
        print(' Rotation at node: ' + node.data.toString());
        rightRotation(node);
      }
    } else if(node.balance == -2) {
      node.right.balance = treeHeight(node.right.left) - treeHeight(node.right.right);
      // print('node ${node.right.data}: ${node.right.balance}');
      printSubtreeToConsole(node);
      if(node.right.balance == 1) { // RL rotation
        stdout.write(Colorize('R')..apply(Styles.LIGHT_MAGENTA));
        stdout.write('(' + node.right.data.toString() + ')');
        stdout.write(Colorize('L')..apply(Styles.LIGHT_BLUE));
        print('(' + node.data.toString() + ') Rotation');
        rightRotation(node.right);
        leftRotation(node);
      } else {
        stdout.write(Colorize('L')..apply(Styles.LIGHT_BLUE));
        print(' Rotation at node: ' + node.data.toString());
        leftRotation(node);
      }
    }
  }

  updateUpwards(Node root) {
    if(root == null) return;
    root.balance = treeHeight(root.left)-treeHeight(root.right);
    root.depth = getNodeDepth(root);
    // print('balance of ${root.data}: ${root.balance}');
    if((root.balance == 2 || root.balance == -2)&&balanced)
      rebalance(root);
    updateUpwards(root.parent);
  }

  treeHeight(Node root) => root == null ?
    -1 : max<int>(treeHeight(root.left), treeHeight(root.right)) + 1;

  leftRotation(Node root) {
    var parent = root.parent;
    var transferNode = root.right.left;
    var newRoot = root.right;
    printLine(Styles.LIGHT_BLUE);
    print(Colorize('L(${root.data})')..apply(Styles.LIGHT_BLUE));
    printRotation(root, [newRoot, newRoot.right, root, root.left, transferNode, root]);
    // printSubtreeToConsole(root);
    print('\t* * *\n');
    if(parent != null) {
      parent.left == root ?
        parent.left = newRoot :
        parent.right = newRoot;
    } else this.root = newRoot;
    newRoot.parent = parent;
    if(transferNode != null)
      transferNode.parent = root;
    root.right = transferNode;
    newRoot.left = root;
    root.parent = newRoot;
    updateBalanceAndDepth(newRoot);
    printRotation(newRoot, [newRoot, newRoot.right, root, root.left, transferNode, root]);
    // printSubtreeToConsole(newRoot);
    printLine(Styles.LIGHT_BLUE);
    stdin.readLineSync();
  }

  rightRotation(Node root) {
    var parent = root.parent;
    var transferNode = root.left.right;
    var newRoot = root.left;
    printLine(Styles.LIGHT_MAGENTA);
    print(Colorize('R(${root.data})')..apply(Styles.LIGHT_MAGENTA));
    printRotation(root, [newRoot, newRoot.left, root, root.right, transferNode]);
    // printSubtreeToConsole(root);
    print('\t* * *\n');
    if(parent != null) {
      parent.left == root ?
        parent.left = newRoot :
        parent.right = newRoot;
    } else this.root = newRoot;
    newRoot.parent = parent;
    if(transferNode != null)
      transferNode.parent = root;
    root.left = transferNode;
    newRoot.right = root;
    root.parent = newRoot;
    updateBalanceAndDepth(newRoot);
    printRotation(newRoot, [newRoot, newRoot.left, root, root.right, transferNode]);
    // printSubtreeToConsole(newRoot);
    printLine(Styles.LIGHT_MAGENTA);
    stdin.readLineSync();
  }

  getNodeDepth(Node node) => node.parent == null ?
      0 : 1 + getNodeDepth(node.parent);

  updateBalanceAndDepth(Node node) {
    if(node != null) {
      updateBalanceAndDepth(node.right);
      node.depth = getNodeDepth(node);
      // print('Updated ${node.data} depth: ${node.depth}');
      node.balance = treeHeight(node.left)-treeHeight(node.right);
      updateBalanceAndDepth(node.left);
    }
  }

  printSubtreeToConsole(Node node) {
    if(node == null)
      return;
    printSubtreeToConsole(node.right);
    printNode(node);
    printSubtreeToConsole(node.left);
  }

  ascendingOrder(Node node) {
    if(node == null)
      return;
    ascendingOrder(node.left);
    printNode(node);
    ascendingOrder(node.right);
  }

  printRotation(node, List<Node> nodes) {
    if(node == null || !nodes.contains(node))
      return;
    printRotation(node.right, nodes);
    if(nodes.contains(node))
      printNode(node);
    printRotation(node.left, nodes);
  }

  printNode(Node node) {
    for(var i = 0; i < node.depth; i++)
      stdout.write('\t');
    if(node.left == null && node.right == null)
      print('<' + node.data.toString() + '(b:' + node.balance.toString() + ')>\n');
    else
      print(node.data.toString() + '(b:' + node.balance.toString() + ')\n');
  }

  printLine(Styles s) {
    String string = '';
    for(int i = 0; i < stdout.terminalColumns; i++)
      string += '-';
    stdout.write(Colorize(string)..apply(s));
    stdout.write('\n');
  }
}

class Node {
  var data = 0;
  int depth = 0;
  int balance = 0;
  Node parent = null;
  Node left = null;
  Node right = null;
  Node(this.data);
  toString() => this.data.toString();
}