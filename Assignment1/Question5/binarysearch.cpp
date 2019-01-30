#include <iostream>
#include <time.h>
#include <math.h>
using namespace std;

int binarySearch(int array[],int target,int arraySize);
void arrTest(int*, const int);

int main() {
	const int
		size1 = 128,
		size2 = 512,
		size3 = 2048,
		size4 = 8192,
		size5 = 32768,
		size6 = 131072,
		size7 = 524288,
		size8 = 2097152;

	int * arr;
	arrTest(arr, size1);
	arrTest(arr, size2);
	arrTest(arr, size3);
	arrTest(arr, size4);
	arrTest(arr, size5);
	arrTest(arr, size6);
	arrTest(arr, size7);
	arrTest(arr, size8);
}

void arrTest(int * arr, const int size) {
	clock_t start;
	arr = new int[size];
	for(int i = 0; i < size; i++)
		arr[i] = i;
	start = clock();
	for(int i = 0; i < 10000000; i++)
		binarySearch(arr, size+1, size);
	cout << "Time elapsed: " << ((double)clock() - start) / CLOCKS_PER_SEC << " Seconds " << endl ;
	delete[] arr;
}

int binarySearch(int array[],int target, int arraySize) {
  int first, mid, last;

  first = 0;
  last = arraySize-1;

	while(first <= last) {
		mid = ceil(first + last) / 2;
		if(array[mid] > target)
			last = mid - 1;
		else if(array[mid] < target)
			first= mid + 1;
		else
			return mid;
	}
  	return -1;
}
