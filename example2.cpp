int fib(int x) {
	if (x < 2) {
		return 1;
	} else {
		return fib(x - 1) + fib(x - 2);
	}
}

int main() {
	int times = 6;
	int result = fib(times);
	cout << result;
	return 0;
}