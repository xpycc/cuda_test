#include <stdio.h>

__global__ void add(int a, int b, int *c) {
	*c = a + b;
}

int main() {
	int c;
	int *dev_c;
	cudaMalloc((void**)&dev_c, sizeof(int));
	add<<<1, 1>>>(2, 7, dev_c);
	cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
	printf("2 + 7 = %d\n", c);
	cudaFree(dev_c);
	cudaGetDeviceCount(&c);
	printf("cuda device count: %d\n", c);
	for (int i = 0; i < c; ++i) {
		cudaDeviceProp prop;
		cudaGetDeviceProperties(&prop, i);
		printf("   --- General Information for device %d ---\n", i);
		printf("Name:  %s\n", prop.name);
		printf("Compute capability:  %d.%d\n", prop.major, prop.minor);
		printf("Clock rate:  %d\n", prop.clockRate);
		printf("Device copy overlap:  %s\n", prop.deviceOverlap ? "Enabled" : "Disabled");
		printf("Kernel execution timeout:  %s\n", prop.kernelExecTimeoutEnabled ? "Enabled" : "Disabled");
		printf("   --- Memory Information for device %d ---\n", i);
		printf("Total global mem: %ld\n", prop.totalGlobalMem);
		printf("Multiprocessor count:  %d\n", prop.multiProcessorCount);
		printf("Threads in wrap:  %d\n", prop.warpSize);
	}
	return 0;
}
