
def scalar_multiplications(p, type):
    size = len(p)-1
    S = [[-1 for _ in range(size)] for _ in range(size)]
    for i in range(size):
        S[i][i] = 0

    c = 1
    while(c < size):
        i = 0
        j = c
        while(j < size):  # stop once at the end of the diagonal
            k = i
            values = []
            while(k != j):  # stop at diagonal
                val = p[i]*p[k+1]*p[j+1] + S[i][k] + S[k+1][j]
                values.append(val)
                k += 1
            S[i][j] = math.ceil(avg(values))
            i += 1
            j += 1
        c += 1
    return S[0][size-1]

