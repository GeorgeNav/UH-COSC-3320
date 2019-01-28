/* By: George Navarro
A Quicksort program with penultimate (second to last element) as pivot element
*/
#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
using namespace std;

void QuickSort(int*, int, int); // Sorts array using QuickSort (pg.73)
    int Partition(int*, int, int); // Returns a penultimate (second to past element) pivot index
    void ShiftLeft(int*, int, int); // Shift elements left
void Swap(int*, int, int); // Swaps elements in array
void arrTest(int*, const int, string);
void PrintArr(int*, int, int); // Prints array

int comparisons = 0;
int swaps = 0;
ofstream out("quicksort-output.txt");

int main() {
    int
    /* Best Case: floor of median is always chosen as the pivot */
        Sb1[1] = {1},
        Sb2[3] = {1,2,3},
        Sb3[7] = {1,2,3,5,6,4,7},
        Sb4[15] = {1,2,3,5,6,4,7,9,10,11,13,14,12,8,15},
        Sb5[31] = {1,2,3,5,6,4,7,9,10,11,13,14,12,8,15,17,18,19,21,22,20,23,25,26,27,29,30,28,24,16,31},
        Sw1[2] = {2,1}, // can be any value
        Sw2[3] = {2,3,1},
        Sw3[4] = {2,3,4,1},
        Sw4[5] = {2,3,4,5,1},
        Sw5[6] = {2,3,4,5,6,1};
    /* Worst Case: largest value is always chosen as the pivot */

    /* Test Arrays */
    // FIXME: best case total is + 2^n then desired complexity starting from Sb5 (array size 11)  
    arrTest(Sb1, 1, "best-case");
    arrTest(Sb2, 3, "best-case");
    arrTest(Sb3, 7, "best-case");
    arrTest(Sb4, 15, "best-case");
    arrTest(Sb5, 31, "best-case");
    arrTest(Sw1, 2, "worst-case");
    arrTest(Sw2, 3, "worst-case");
    arrTest(Sw3, 4, "worst-case");
    arrTest(Sw4, 5, "worst-case");
    arrTest(Sw5, 6, "worst-case");

    out.close();
}

void arrTest(int S[], const int n, string c) {
    std::cout << endl << "QuickSort -> ";
        out << endl << "QuickSort -> ";
    PrintArr(S, 0, n);
    QuickSort(S, 0, n-1);
    std::cout << endl << "             ";
        out << endl << "             ";
    PrintArr(S, 0, n);
    std::cout << endl << "    Total: " << comparisons << " comparisons + " << swaps << " swaps = " << comparisons + swaps << endl;
        out << endl << "    Total: " << comparisons << " comparisons + " << swaps << " swaps = " << comparisons + swaps << endl;
    if(c == "best-case") {
    std::cout << "    Complexity: " << "n*log2(n) = " << n << "*log2(" << n << ") = "  << n*log2(n) << endl;
        out << "    Complexity: " << "n*log2(n) = " << n << "*log2(" << n << ") = "  << n*log2(n) << endl;
    } else if(c == "worst-case") {
    std::cout << "    Complexity: " << "n^2 = " << n << "^2" << " = "  << n*n << endl;
        out << "    Complexity: " << "n^2 = " << n << "^2" << " = "  << n*n << endl;
    }
    swaps = 0;
    comparisons = 0;
}

void QuickSort(int S[], int l, int r) {
    if(l < r) {
        int pivotPos = Partition(S, l, r); // best case: median of subarray / worst case: largest of subarray
        QuickSort(S, l, pivotPos-1);
        QuickSort(S, pivotPos+1, r);
    } // else array only has 1 element so no sorting needed
}

int Partition(int S[], int l, int r) {
    int pivotPos = r-1; // best case: median of subarray / worst case: largest of subarray
    int pivotVal = S[pivotPos];
    int i = l; // remembers the first thing (starting from l) that is larger than pivot value
    int j = l; // remembers where we are and where we are going?

    while(j <= r) { // Swap elements around future pivot location
        if(j != pivotPos) {
            if(S[j] < pivotVal) { // check if same element (no need to swap) and if current element is greater than pivot
                if(j > pivotPos) pivotPos = r;
                Swap(S, i, j);
                i++;
            } // the value is greater than or equal to value at S[j]
            comparisons++;
        }
        j++;
    }
    Swap(S, pivotPos, i); // swaps pivot value to the correct position if needed
    return i;
}

void Swap(int S[], int a, int b) {
/*     if(a != b) { */
        int temp = S[a];
        S[a] = S[b];
        S[b] = temp;
        swaps++;
/*     } */
}

void PrintArr(int S[], int i, int n) {
    if(i == n) {
        std::cout << "<empty>";
            out << "<empty>";
        return;
    }
    std::cout << "[";
        out << "[";
    for(int i = 0; i < n; i++) {
        std::cout << S[i];
            out << S[i];
        if(i != n-1) {
            std::cout << ", ";
                out << ", ";
        }
    }
    std::cout << "]";
    out << "]";
}
