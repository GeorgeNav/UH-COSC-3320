
def gcd(a_val, b_val):
    a = a_val if a_val > b_val else b_val
    b = b_val if a_val > b_val else a_val
    q = None
    r = -1

    print("a = {0}, b = {1}".format(a, b))
    print("a = q * b + r")
    aqbr = []

    while(r != 0):
        q = a//b # int value (desreguarding decimal)
        r = a%b # remainder when dividing
        print("{0} = {1} * {2} + {3}"
                .format(a, q, b, r))
        aqbr.append([a, q, b, r])
        a = b
        b = r
    
    print("gcd({0},{1}) = {2}".format(a_val, b_val, a))

    for row in aqbr:
        print(row)

"""     i = len(aqbr-1)
    while(i >= 0):
        print("{0} - {1} * {2} = {3}"
                .format(a, q, b, r)) """



gcd(65536,32677)