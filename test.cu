#include <stdio.h>

int main() {
	int c;
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
		printf("Total global mem:  %ld\n", prop.totalGlobalMem);
		printf("Total constant mem:  %ld\n", prop.totalConstMem);
		printf("Max mem pitch:  %ld\n", prop.memPitch);
		printf("Texture alignment:  %ld\n", prop.textureAlignment);
		printf("   --- MP Information for device %d ---\n", i);
		printf("Multiprocessor count:  %d\n", prop.multiProcessorCount);
		printf("Shared mem per mp:  %ld\n", prop.sharedMemPerBlock);
		printf("Registers per mp:  %d\n", prop.regsPerBlock);
		printf("Threads in wrap:  %d\n", prop.warpSize);
		printf("Max threads per block:  %d\n", prop.maxThreadsPerBlock);
		printf("Max thread dimensions:  (%d, %d, %d)\n",
				prop.maxThreadsDim[0], prop.maxThreadsDim[1],
				prop.maxThreadsDim[2]);
		printf("Max grid dimensions:  (%d, %d, %d)\n",
				prop.maxGridSize[0], prop.maxGridSize[1],
				prop.maxGridSize[2]);
		puts("");
	}
	return 0;
}
