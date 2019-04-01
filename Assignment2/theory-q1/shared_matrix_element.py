import os
import random
from pprint import pprint

os.system('clear')  # For Linux/OS X
n = random.randint(1,1000)  # pick a random n
A = [[0 for _ in range(n)] for _ in range(n)]  # create n*n matrix of 0's
B = [[0 for _ in range(n)] for _ in range(n)]  # create n*n matrix of 0's

C = A[:]  # copy contents of A into C to make it identical (n^2)

for i in range(n):  # change contents of B (n^2)
    for j in range(n):
        B[i][j] += 1

for i in range(n):  # compare all elements of A to C elements (n^2)
    for j in range(n):
        if A[i][j] != C[i][j]:
            print('An element is shared between A and B')
            break

for i in range(n):  # change changed elements of B back (n^2)
    for j in range(n):
        B[i][j] -= 1

