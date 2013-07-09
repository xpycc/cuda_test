__device__ int N;

__global__ void set_N(int n) {
	N = n;
}

__global__ void dev_add(int *a, int *b, int *c) {
	int id = blockIdx.x;
	if (id < N)
		c[id] = a[id] + b[id];
}

void add(int a[], int b[], int c[], int n) {
	int *dev_a, *dev_b, *dev_c;
	set_N<<<1, 1>>>(n);
	cudaMalloc(&dev_a, n * sizeof(int));
	cudaMalloc(&dev_b, n * sizeof(int));
	cudaMalloc(&dev_c, n * sizeof(int));
	cudaMemcpy(dev_a, a, n * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, n * sizeof(int), cudaMemcpyHostToDevice);
	dev_add<<<n, 1>>>(dev_a, dev_b, dev_c);
	cudaMemcpy(c, dev_c, n * sizeof(int), cudaMemcpyDeviceToHost);
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);
}

__global__ void dev_add_n(int *a, int *b, int *c, int N) {
	int id = blockIdx.x;
	if (id < N)
		c[id] = a[id] + b[id];
}

void add_n(int a[], int b[], int c[], int n) {
	int *dev_a, *dev_b, *dev_c;
	cudaMalloc(&dev_a, n * sizeof(int));
	cudaMalloc(&dev_b, n * sizeof(int));
	cudaMalloc(&dev_c, n * sizeof(int));
	cudaMemcpy(dev_a, a, n * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, n * sizeof(int), cudaMemcpyHostToDevice);
	dev_add_n<<<n, 1>>>(dev_a, dev_b, dev_c, n);
	cudaMemcpy(c, dev_c, n * sizeof(int), cudaMemcpyDeviceToHost);
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);
}
