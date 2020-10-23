int main() {
	cout << "talk with me...\n";
	cout << "lets make a tower together. you will write string and i will concatenate them...\n";
	cout << "print STOP if you want to stop...\n";
	string str = "";
	string ins = "";
	bool flag = True;
	while (flag) {
		getline(cin, ins);
		str = str + ins;
		cout << "current string is: " + str + "\n";
		if (ins == "STOP") {
			flag = False;
		} else {
			flag = True;
		}
	}
	return 0;
}