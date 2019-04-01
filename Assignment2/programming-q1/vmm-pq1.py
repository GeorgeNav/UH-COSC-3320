import math
import os
import time

def vmm(n):
    A = [[1 for _ in range(n)] for _ in range(n)]
    B = [[1 for _ in range(n)] for _ in range(n)]
    C = [[1 for _ in range(n)] for _ in range(n)]
    start = time.time()
    for i in range(n): # go row by row (good, since python uses row major)
        for j in range(n):
            C[i][j] = A[i][j] + B[i][j]
    end = time.time()
    print('\trow by row: ' + '{0:.4f}'.format(end - start) + ' seconds')
    f.write('{0:.4f}'.format(end - start) + ', ')

    A = [[1 for _ in range(n)] for _ in range(n)]
    B = [[1 for _ in range(n)] for _ in range(n)]
    C = [[1 for _ in range(n)] for _ in range(n)]
    start = time.time()
    for j in range(n): # go column by column (bad, since python does not use column major)
        for i in range(n):
            C[i][j] = A[i][j] + B[i][j]
    end = time.time()
    print('\tcolumn by column: ' + '{0:.4f}'.format(end - start) + ' seconds')
    f.write('{0:.4f}'.format(end - start) + '\n')


dir_path = os.path.dirname(__file__)
n_values = [128, 256, 512, 1024, 2048, 8192, 16384, 32768, 65536]
output_file_path = os.path.join(dir_path, 'output.txt')
with open(output_file_path, 'w') as f:
    f.write('n, columns(seconds), rows(seconds)\n')
    for n in n_values:
        print('n = ' + str(n))
        f.write(str(n) + ', ')
        vmm(n)

