const
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

function arrTest(size) {
    let array = Array.from(Array(size).keys());
    console.time("test");
	for(let i = 0; i < 10000000; i++)
        binarySearch(array, size+1);
    console.log("Time elapsed: ");
    console.timeEnd("test");
}

function binarySearch(array, target) {
    let first, mid, last;
    first = 0;
    last = array.length-1;

	while(first <= last) {
		mid = Math.ceil((first + last) / 2);
		if(array[mid] > target)
			last = mid - 1;
		else if(array[mid] < target)
			first= mid + 1;
		else
			return mid;
	}
  	return -1;
}
