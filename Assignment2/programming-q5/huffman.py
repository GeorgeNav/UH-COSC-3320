# based on lengths of assigned codes based on frequencies
# variable length codes: prefix codes
import os
import time
import math
import random
import sys
from btree import *


class Huffman:
    def __init__(self):
        print('Name of input file in relative directory (input.txt)?: ',
              end='',
              flush=True)
        # f_name = str(input())
        f_name = 'input.txt'
        print()
        # access input file
        self.dir_path = os.path.dirname(__file__)
        input_file_path = os.path.join(self.dir_path, f_name)
        self.f_table = []
        self.chars = []
        self.char_count = 0
        self.char_map = {}
        with open(input_file_path) as f:
            c = f.read(1)
            while c:
                self.chars.append(c)
                self.char_count += 1
                index = self.find_existing_char(c)
                if index == -1:  # char does not exist in frequency table
                    self.f_table.append(Node(c, 1))
                    self.char_map[c] = self.f_table[-1]
                else:  # char already exists in frequency table
                    self.f_table[index].freq += 1
                c = f.read(1)
        self.f_table_len = len(self.f_table)
        self.visited = [0 for i in range(len(self.f_table))]
        print('No steps or animations (0),\nAnimate (1),\nJust steps (2)?: ',
              end='',
              flush=True)
        self.animate = int(input())
        self.trees = []

        while not self.everything_visited():
            self.insert_lowest()
        self.print_f_table()
        self.decode(self.encode())

        os.system('perl -ne \'print pack("B2", $_)\' < encoded_message.txt > encoded_message.bin')

    def find_existing_char(self, c):
        if len(self.f_table) == 0:
            return -1
        for index, char in enumerate(self.f_table):
            if c == char.char:
                return index
        return -1

    def insert_lowest(self):
        self.print_not_visited()
        if self.animate == 1:
            input()

        l = None
        l_index = -1
        for i, v in enumerate(self.visited):
            if v == 0:
                if(l is None or
                   l is not None and
                   self.f_table[i].freq < l.freq):
                    l = self.f_table[i]
                    l_index = i
        self.visited[l_index] = 1

        h = None
        h_index = -1
        for i, v in enumerate(self.visited):
            if v == 0:
                if(h is None or
                   h is not None and
                   self.f_table[i].freq < h.freq and
                   self.f_table[i].freq >= l.freq):
                    h = self.f_table[i]
                    h_index = i
        self.visited[h_index] = 1

        self.current_tree = HuffmanBinaryTree([], self.animate)
        root = Node(l.freq + h.freq, l.freq + h.freq)
        self.f_table.append(root)
        self.visited.append(0)
        self.current_tree.insert(root, l, h)
        self.current_tree.print_tree()

    def encode(self):
        encoded_message = []
        for char in self.chars:
            print(char, end='', flush=True)
            encoded_message.append(self.char_map[char].code)
        print('\n' + str(encoded_message))
        output_file_path = os.path.join(self.dir_path, 'encoded_message.txt')
        with open(output_file_path, 'w') as f:
            for code in encoded_message:
                #f.write(str(code) + '\n')
                f.write(str(code))
        return encoded_message

    def decode(self, encoded_message):
        print('Decoding encoded message using tree...')
        decoded_message = ''
        for code in encoded_message:
            decoded_message += str(
                self.current_tree.find_char(
                    self.current_tree.get_root(),
                    code))
        print(decoded_message)
        output_file_path = os.path.join(self.dir_path, 'decoded_message.txt')
        with open(output_file_path, 'w') as f:
            for char in decoded_message:
                f.write(char)

    def everything_visited(self):
        count = 0
        for v in self.visited:
            if v == 0:
                count += 1
        if count == 1:
            return True
        else:
            return False

    def print_not_visited(self):
        print('chars/roots left: ', end='', flush=True)
        for i, v in enumerate(self.visited):
            if v == 0:
                if self.f_table[i].get_char() == '\n':
                    print('\\n', end='', flush=True)
                elif self.f_table[i].get_char() == '\t':
                    print('\\t', end='', flush=True)
                else:
                    print(self.f_table[i].get_char(), end='', flush=True)
                print(':' +
                      str(self.f_table[i].freq) +
                      ' | ',
                      end='',
                      flush=True)
        print()

    def print_f_table(self):
        for i, node in enumerate(self.f_table):
            if i < self.f_table_len:
                print(node.char_info())

Huffman()
