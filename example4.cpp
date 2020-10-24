int main() {
	int t = 16;
	int x = t;
	while (x < (t * t)) {
		cout << x;
		cout << "\n";
		x = 2 * x;
	}
	return 0;
}