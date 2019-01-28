import "dart:core";

main() {
	const int
		size1 = 128,
		size2 = 512,
		size3 = 2048,
		size4 = 8192,
		size5 = 32768,
		size6 = 131072,
		size7 = 524288,
		size8 = 2097152;

	arrTest(size1);
	arrTest(size2);
	arrTest(size3);
	arrTest(size4);
	arrTest(size5);
	arrTest(size6);
	arrTest(size7);
	arrTest(size8);
}

void arrTest(int size) {
  var array = new List<int>.generate(size, (i) => i + 1);
  var clock = new Stopwatch();
  clock.start();
	for(var i = 0; i < 10000000; i++)
    binarySearch(array, size+1);
  clock.stop();
  print("Time elapsed: " + clock.elapsed.toString());
}

int binarySearch(List array, int target) {
  var first, mid, last;
  first = 0;
  last = array.length-1;

	while(first <= last) {
		mid = ((first + last) / 2).ceil();
		if(array[mid] > target)
			last = mid - 1;
		else if(array[mid] < target)
			first= mid + 1;
		else
			return mid;
	}
  	return -1;
}
