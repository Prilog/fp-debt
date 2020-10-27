int main() {
  string cur = "";
  bool flag = true;
  while (flag) {
    getline(cin, cur);
    cout << "Have read " + cur + "\n";
    if (cur == "STOP") {
      flag = false;
    } else {
      flag = true;
    }
  }
  return 0;
}