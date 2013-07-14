#include <stdio.h>
#define N 10

__global__ void dev_add_n(float *a, float *b, float *c, int n) {
	__shared__ float tmp[N];
	int id = threadIdx.x;
	if (id < N / 2) {
		tmp[id] = a[id] + b[id];
		__syncthreads();
	}
	c[id] = tmp[id];
}

void add_n(float a[], float b[], float c[], int n) {
	float *dev_a, *dev_b, *dev_c;
	cudaMalloc(&dev_a, n * sizeof(float));
	cudaMalloc(&dev_b, n * sizeof(float));
	cudaMalloc(&dev_c, n * sizeof(float));
	cudaMemcpy(dev_a, a, n * sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, n * sizeof(float), cudaMemcpyHostToDevice);
	dev_add_n<<<1, n>>>(dev_a, dev_b, dev_c, n);
	cudaMemcpy(c, dev_c, n * sizeof(float), cudaMemcpyDeviceToHost);
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);
}

int main() {
	float a[N] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
		b[N] = {0, 1, 2 ,3, 4, 5, 6 ,7, 8, 9},
		c[N] = {0};
	add_n(a, b, c, N);
	for (int i = 0; i < N; ++i)
		printf("c[%d] = %.3f%c", i, c[i], i + 1 == N ? '\n' : ' ');
}
