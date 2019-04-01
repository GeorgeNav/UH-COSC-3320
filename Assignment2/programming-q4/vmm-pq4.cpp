#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/statvfs.h>

int main() {
    const int c_size = 15;
    double C[c_size] = {0.5, 0.6, 0.7, 0.8, 0.9,
                        0.95, 0.99, 1.0, 1.01, 1.1,
                        1.5, 2, 5, 10, 50};
    unsigned long long available_mem =
        (unsigned long long)(sysconf(_SC_PHYS_PAGES) *
        sysconf(_SC_PAGE_SIZE));
    printf("Starting test...\n\n");
    for(int c = 0; c < c_size; c++) {
        time_t t = clock();
        printf("C = %.2f     ->    ", C[c]);

        unsigned long long bytes_to_allocate = C[c] * available_mem * 0.3;
        printf("%llu\n", bytes_to_allocate);
        // Number of ints that fit into total free bytes
        const unsigned long long size = bytes_to_allocate / sizeof(int);
        int * int_array = new int[size];

        for(unsigned long long i = 0; i < size; i++)
            int_array[i] = 0;

        for(unsigned long long i = 0; i < size; i++)
            int_array[i]++;

        delete [] int_array;

        t = (clock() - t);
        printf("Elapsed Time: %.4f\n\n", ((double)t)/CLOCKS_PER_SEC);
    }
    return 0;
}

