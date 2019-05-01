import os
import time
import math
import random
import sys

print(sys.version)


class Colors:
    DEFAULT = '\033[0m'
    BLACK = '\033[30m'
    RED = '\033[31m'
    GREEN = '\033[32m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    PURPLE = '\033[35m'
    CYAN = '\033[36m'
    WHITE = '\033[37m'


class Node:
    def __init__(self, char, freq):
        self.p: Node = None  # parent
        self.l: Node = None  # left child
        self.r: Node = None  # right child
        self.h: int = 0  # height
        self.d: int = 0  # depth
        self.b = None  # balance
        self.char = char
        self.code = ''
        self.freq = freq # frequency

    def char_info(self):
        # TODO: add this functionality
        char = str(self.char) if self.char != '\n' else '\\n'
        return '\'' + char + '\'\t\t\t' + ' code: ' + str(self.code) + '\t\t\t freq: ' + str(self.freq)

    def get_char(self):
        return str(self.char)

    def __str__(self):
        char = str(self.char) if self.char != '\n' else '\\n'
        if self.l is None and self.r is None:
            print('<' + char + '>' +
                  '(f:' + str(self.freq) + ')', end='', flush=True)
        else:
            print(char + '(f:' + str(self.freq) + ')', end='', flush=True)
        print(Colors.DEFAULT)


class HuffmanBinaryTree:
    def __init__(self, all_info, animate):
        self.root = None
        self.last = None
        self.error = False
        self.num_nodes = 0
        self.animate = animate
        if self.animate == 0:
            block_print()
        #for info in all_info:
        #    self.insert(Node(info), self.root)
            # time.sleep(0.25)
        self.last = None
        #if self.animate == 0:
        #    self.enable_print()
        #    print('Inserted all ' + str(len(array)) + ' values:')
        #    self.rev_order(self.root)

    def insert(self, root, rootl, rootr):
        if self.root == None:
            self.root = root
            self.point(root, rootl, rootr)
            self.update_balance(rootl)
            self.update_balance(rootr)
            self.update_depth(self.root)
            self.get_codes(self.root)
        else:
            self.root = root
            self.point(root, rootl, rootr)
            self.update_balance(rootl)
            self.update_balance(rootr)
            self.update_depth(self.root)
            self.get_codes(self.root)

    def update_balance(self, node):
        if node == None:
            return

        lh = self.height(node.l)
        rh = self.height(node.r)

        tempb = node.b  # used just to check if balance is correct at the end
        if lh != None and rh != None:
            node.b = lh - rh
        elif lh != None:
            node.b = lh
        elif rh != None:
            node.b = rh
        else:
            node.b = 0

        self.update_balance(node.p)

    def height(self, root):
        if root == None:
            return -1
        if root != None:
            lh = self.height(root.l)
            rh = self.height(root.r)
            return max(lh, rh) + 1

    def point(self, root, left, right):
        if left != None:
            root.l = left
            left.p = root
        if right != None:
            root.r = right
            right.p = root

    def rev_order(self, node):
        if node is None:
            return
        self.rev_order(node.r)
        self.print_node(node)
        self.rev_order(node.l)

    def update_depth(self, node):
        if node is None:
            return
        self.update_depth(node.r)
        node.d = self.get_depth(node)
        self.update_depth(node.l)

    def get_depth(self, node):
        if node == self.root:
            return 0
        else:
            return 1 + self.get_depth(node.p)

    def print_tree(self):
        self.rev_order(self.root)
    
    def is_empty(self):
        if self.root == None:
            return True
        else:
            return False
    
    def get_root(self):
        return self.root

    def print_node(self, node):
        for i in range(node.d):
            print('\t\t', end='', flush=True)
        if self.last is node:
            print(Colors.GREEN, end='', flush=True)
        else:
            print(Colors.CYAN, end='', flush=True)
        node.__str__()

    def print_line(self, color):
        rows, columns = os.popen('stty size', 'r').read().split()
        for _ in range(int(columns)):
            print(color + '-' + Colors.DEFAULT, end='', flush=True)
        print()

    def get_codes(self, node):
        if node is None:
            return
        self.get_codes(node.r)
        if node.l == None and node.r == None:
            node.code = str(self.get_code(node))[::-1]
        self.get_codes(node.l)
    
    def get_code(self, node):
        if node.p != None and node.p.l == node:
            return '0' + str(self.get_code(node.p))
        elif node.p != None and node.p.r == node:
            return '1' + str(self.get_code(node.p))
        else:
            return ''
    
    def find_char(self, node, code):
        if node.l == None and node.r == None:
            return node.get_char()
        elif code[0] == '0':
            if node != None:
                return self.find_char(node.l, code[1:])
        elif code[0] == '1':
            if node != None:
                return self.find_char(node.r, code[1:])


# Disable
def block_print():
    sys.stdout = open(os.devnull, 'w')

# Restore
def enable_print():
    sys.stdout = sys.__stdout__
