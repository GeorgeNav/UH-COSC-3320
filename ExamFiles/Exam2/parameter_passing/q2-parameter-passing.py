import random

def check_prods_multi(A, B, C): # A, B, C, are passed by reference
    n = len(A) # 1 unit of space
    # Initialize local B_temp and C_temp arrays to 1
    #   Time Complexity: 2n
    #   Space Complexity: 1 unit + 2n units
    B_temp, C_temp = ([1 for _ in range(n)] for i in range(2))

    # CheckSums Body
    #   Time complexity = 2(n^2)
    #   Space complexity = 2 units
    for i in range(n): # 1 unit of space
        for k in range(n): # 1 unit of space
            B_temp[i] = B_temp[i] * A[i][k] # n^2 time complexity
            C_temp[i] = C_temp[i] * A[k][i] # n^2 time complexity
    
    # Copy the new contents into the original B and C 
    #   Time Complexity = 2n = n + n
    #   Space Complexity = 1 unit
    for i in range(n): # 1 unit of space
        B[i] = B_temp[i] # n time complexity
        C[i] = C_temp[i] # n time complexity


def check_prods_sum(A, B, C): # A, B, C, and n are passed by reference
    n = len(A) # 1 unit of space
    # Initialize local B_temp and C_temp arrays to 0
    #   Time Complexity: 2n
    #   Space Complexity: 1 unit + 2n units
    B_temp, C_temp = ([0 for _ in range(n)] for i in range(2))

    # CheckSums Body
    #   Time complexity = 2(n^2)
    #   Space complexity = 2 units
    for i in range(n): # 1 unit of space
        for k in range(n): # 1 unit of space
            B_temp[i] = B_temp[i] + A[i][k] # n^2 time complexity
            C_temp[i] = C_temp[i] + A[k][i] # n^2 time complexity
    
    # Copy the new contents into the original B and C 
    #   Time Complexity = 2n = n + n
    #   Space Complexity = 1 unit
    for i in range(n): # 1 unit of space
        B[i] = B_temp[i] # n time complexity
        C[i] = C_temp[i] # n time complexity

n = 5
A = [[random.randint(1,9) for _ in range(n)] for _ in range(n)]
B = [0 for _ in range(n)]
C = [0 for _ in range(n)]

check_prods_multi(A, B, C)
check_prods_multi(A, A[0], [row[0] for row in A]) # first row of A for B, first column of A for C
check_prods_sum(A, B, C)
check_prods_sum(A, A[0], [row[0] for row in A]) # first row of A for B, first column of A for C
