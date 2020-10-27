bool satisfy(int x, int y) {
  if (x < 10) {
    if (y > 4) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

int main() {
  int a = 7;
  int b = 7;
  while (satisfy(a, b)) {
    cout << a;
    cout << " ";
    cout << b;
    cout << "\n";
    a = a + 1;
    b = b - 1;
  }
  cout << "finished\n";
  return 0;
}