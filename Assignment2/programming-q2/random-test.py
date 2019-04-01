import random
import numpy
import time
import fastrand


start = time.time()
for _ in range(10000000):
    #x = random.randint(0,1000000000)
    x = fastrand.pcg32bounded(1000000000)
end = time.time()
print('fastrand: ' + str((end - start)) + ' seconds')
start = time.time()

for i in range(10000000):
    x = random.randint(0,1000000000)
end = time.time()
print('randint: ' + str((end - start)) + ' seconds')

n_values = [i for i in range(16384)]
for i in range(10000000):
    x = random.choice(n_values)
end = time.time()
print('random.choice: ' + str((end - start)) + ' seconds')
