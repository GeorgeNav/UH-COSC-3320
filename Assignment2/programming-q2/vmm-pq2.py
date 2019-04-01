import os
import time
import random


def in_core(n):
    m_values = [1677721600, 13421772800]

    for m in m_values:
        print('\tCreating ' + str(n) + ' by ' + str(n) +
              ' matrix (all elements set to 0)... ', end='', flush=True)
        M = [[0 for _ in range(n)] for _ in range(n)] # n by n matrix elements are all set to 0
        print('DONE\n', end='', flush=True)
        print('\tm = ' + str(m) + '\t: ', end='', flush=True)
        start = time.time()
        for i in range(m): # use values 0 through m-1 (total of m values)
            M[random.randint(0,n-1)][random.randint(0,n-1)] += i
        end = time.time()
        print("{0:.4f}".format(end - start) + ' seconds')
        f.write(str(n) + ', ' + str(m) + ', ' + str("{0:.4f}".format(end - start)) + '\n')

    # print(M)
    # print('\n'.join([''.join(['{:4}'.format(item) for item in row]) 
    #    for row in M]))


dir_path = os.path.dirname(__file__)
n_values = [16, 64, 256, 1024, 4096, 16384]
output_file_path = os.path.join(dir_path, 'output.txt')
with open(output_file_path, 'w') as f:
    f.write('n, m, seconds\n')
    for n in n_values:
        print('n = ' + str(n))
        in_core(n)

