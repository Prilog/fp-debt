void ping() {
	cout << "pong";
}

void work_untill_death() {
	while(True) {
		ping();
	}
}

int main() {
	work_untill_death();
	return 0;
}