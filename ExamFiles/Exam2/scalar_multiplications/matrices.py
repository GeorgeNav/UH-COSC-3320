import os
import random
import math
from statistics import mean
from pprint import pprint


def multiply(A, B, C):
    num_rows = len(A)
    num_cols = len(B[0])

    scalar_multiplications = 0
    for i in range(num_rows):
        for j in range(num_cols):
            C[i][j] = 0
            for k in range(len(B)):
                C[i][j] += A[i][k] * B[k][j]
                scalar_multiplications += 1
    return scalar_multiplications


def example():
    Ar = random.randint(1, 4)
    Ac = random.randint(1, 4)
    A = [[random.randint(0, 9) for i in range(Ac)] for j in range(Ar)]
    Br = Ac
    Bc = random.randint(1, 4)
    B = [[random.randint(0, 9) for i in range(Bc)] for j in range(Br)]
    C = [[0 for i in range(Bc)] for j in range(Ar)]
    os.system('clear')  # For Linux/OS X
    print('Multiplying... A ({0}, {1}) and B ({2}, {3})'
          .format(Ar, Ac, Br, Bc))
    print('\tA: {0}'.format(A))
    print('\tB: {0}'.format(B))
    print('\tScalar Multiplications: {0}'.format(multiply(A, B, C)))
    print('\tC: {0}'.format(C))


def scalar_multiplications(p, type):
    print('\n\nWork for ' + type + '...\n')
    size = len(p)-1
    S = [[-1 for _ in range(size)] for _ in range(size)]
    for i in range(size):
        S[i][i] = 0

    options = {
        'max': lambda value: max(value),
        'min': lambda value: min(value),
        'avg': lambda value: mean(value)
    }

    c = 1
    while(c < size):
        i = 0
        j = c
        while(j < size):  # stop once at the end of the diagonal
            k = i
            values = []
            print('Getting S[{0}][{1}]...'.format(i+1, j+1))
            while(k != j):  # stop at diagonal
                val = p[i]*p[k+1]*p[j+1] + S[i][k] + S[k+1][j]
                values.append(val)
                print('\tp{0}*p{4}*p{1} + S[{0}][{2}] + S[{4}][{3}]'
                      .format(i+1, j+2, k+1, j+1, k+2) + ' = ' +
                      '{0}*{1}*{2} + {3} + {4} = {5}'
                      .format(p[i], p[k+1], p[j+1], S[i][k], S[k+1][j], val))
                k += 1
            S[i][j] = math.ceil(options[type](values))
            print('\t\t{0}({1}) = {2}'
                  .format(type,
                          str(values)
                          .replace('[', '')
                          .replace(']', ''),
                          S[i][j]))
            i += 1
            j += 1
        c += 1
    print('\n')
    for row in S:
        print(row)
    print('\n')
    return S[0][size-1]


# Passing parameters
# formal <--> actual
# 1) passing by value
#       each actual parameter coresponds to a value
#       each formal parameter coresponds to a local variable
#       values from actual are copied into the memory locations of the formal
#       function loading is as entered as if the formula were local variables
# 2) passing by reference
#       each actual must corespond to a memory location
#       each formal refers to the coresponding actual parameter memory location
#       each exit the body
# 3) passing by name
