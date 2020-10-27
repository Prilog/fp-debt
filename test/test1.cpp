string aba(string a, string b) {
	return a + b + a;
}

string aaa(int n, string s) {
	int t = 0;
	string res = "";
	while (t < n) {
		res = res + s;
		t = t + 1;
	}
	return res;
}

int main() {
	cout << "What is your name?\n";
	string name = "";
	getline(cin, name);
	bool is_gay = (name == "kirill");
	if (is_gay) {
		cout << "go delat' teorver\n";
	} else {
		cout << "Hello, " + name + "!\n";	
	}
	string k = "kirill";
	string p = "botai";
	int times = 5;
	cout << aba(k, aaa(times, p));
	return 0;
}