import math
import sys
import time
import random
from random import randrange, uniform


def median(S):
    return sorted(S)[int(len(S)/2)]


def select(S, k):
    if len(S) is 1:
        return S[0]
    m = choose_pivot(S)
    L = []
    E = []
    G = []
    for i in range(len(S)):
        if S[i] == m:
            E.append(S[i])
        elif S[i] < m:
            L.append(S[i])
        elif S[i] > m:
            G.append(S[i])
    
    if len(G) >= k:
        return select(G, k)
    elif len(G) + len(E) >= k:
        return m
    else:
        return select(L, k - (len(G) + len(E)))


def choose_pivot(S):
    num_groups = int(math.ceil(len(S)/5.0))
    M = []

    for i in range(num_groups-1):
        sub_arr = S[5*i:5*(i+1)]
        M.append(median(sub_arr))
    sub_arr = S[5*(num_groups-1):]
    M.append(median(sub_arr))
    return select(M, int(math.ceil(len(S)/10.0)))


sys.stdout.write('Choose an array size: ')
size = int(input())
array = []
for i in range(size):
    array.append(randrange(-10000, 10000))

sys.stdout.write('Choose k: ')
kth = int(input())
print("Finding kth largest...")

if size <= 20:
    print("array\t:" + str(array))
    print("sorted\t:" + str(sorted(array)))

start = time.time()*1000
m1 = select(array, kth)
end = time.time()*1000
time1 = end - start

start = time.time()*1000
m2 = str(sorted(array)[len(array)-kth])
end = time.time()*1000
time2 = end - start

assert(m1 == sorted(array)[len(array)-kth])
print(str(m1) + " (" + "{0:.2f}".format(time1) + "ms) ... " + str(m2) + " (" + "{0:.2f}".format(time2) + "ms)")
