
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


__global__ void unique_gid_calculation_2D(int* input) {
	int tid = threadIdx.x;
	int block_offset = blockIdx.x * blockDim.x;
	int row_offset = blockDim.x * gridDim.x * blockIdx.y;
	int gid = block_offset + row_offset + tid; // global index
	printf("blockIdx.x : %d, blockIdx.y : %d threadIdx : %d, gid : %d value : %d \n"
		,blockIdx.x, blockIdx.y, tid, gid, input[gid]);



}


int main() {

	int array_size = 16;
	int array_byte_size = sizeof(int) * array_size;
	int h_data[] = { 23,9,4,53,65,12,1,33,87,45,23,12,342,56,44,99 };
	printf("My Array List :");
	for (int i = 0; i < array_size; i++) {
		printf("%d ", h_data[i]);
	}
	printf("\n \n");

	int* d_data;
	cudaMalloc((void**)&d_data, array_byte_size);
	cudaMemcpy(d_data, h_data, array_byte_size, cudaMemcpyHostToDevice);

	dim3 block(4);
	dim3 grid(2,2);



	unique_gid_calculation_2D << < grid, block >> > (d_data);
	cudaDeviceSynchronize();

	cudaDeviceReset();
	return 0;
}

