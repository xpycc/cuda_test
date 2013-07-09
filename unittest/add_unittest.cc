#include <gtest/gtest.h>
#include <stdlib.h>
#include <time.h>
#include "../add.h"

const int N = 60000;

TEST(add_test, cuda_test) {
	srand((long)time(NULL));
	for (int cc = 0; cc < 20; ++cc) {
		// printf("Test Loop %d:  ", cc); fflush(stdout);
		int a[N], b[N], c[N], i;
		for (i = 0; i < N; ++i)
			a[i] = rand() & 65535, b[i] = rand() & 65535;
		add(a, b, c, N);
		for (i = 0; i < N; ++i)
			if (a[i] + b[i] != c[i])
				break;
		if (i < N) {
			fprintf(stderr, "\n\nWrong answer at index = %d, %d + %d != %d !!!\n", i, a[i], b[i], c[i]);
			ASSERT_TRUE(false) << "Fall into a trap!";
		}
		// puts("PASS");
	}
}

TEST(add_n_test, cuda_test) {
	srand((long)time(NULL));
	for (int cc = 0; cc < 20; ++cc) {
		// printf("Test Loop %d:  ", cc); fflush(stdout);
		int a[N], b[N], c[N], i;
		for (i = 0; i < N; ++i)
			a[i] = rand() & 65535, b[i] = rand() & 65535;
		add_n(a, b, c, N);
		for (i = 0; i < N; ++i)
			if (a[i] + b[i] != c[i])
				break;
		if (i < N) {
			fprintf(stderr, "\n\nWrong answer at index = %d, %d + %d != %d !!!\n", i, a[i], b[i], c[i]);
			ASSERT_TRUE(false) << "Fall into a trap!";
		}
		// puts("PASS");
	}
}
