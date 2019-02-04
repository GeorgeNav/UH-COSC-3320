#include <iostream>
#include <string>

class Stack {
private:
	int *_list;
	int _length;
	int _maxSize;
	std::string _name;

public:
	Stack(int maxSize, std::string name) {
		_list = new int[maxSize];
		for(int i = 0; i < maxSize; i++)
			_list[i] = 0;
		_maxSize = maxSize;
		_length = 0;
		_name = name;
	}

	~Stack() { delete[] _list; }

	int length() { return _length; }

	int maxSize() { return _maxSize; }

	std::string getName() { return _name; }

	bool isEmpty() { return _length == 0; }

	bool isFull() { return _length == _maxSize; }

	int top() {
		if(!isEmpty())
			return _list[_length-1];
		else
			return -1;
	}

	void push(int value) {
		if(!isFull())
			_list[_length++] = value;
	}

	int pop() {
		int value;
		if(_length > 0) {
			value = _list[_length-1];
			_list[--_length] = 0;
		} else
			value = 0;
		return value;
	}
};
