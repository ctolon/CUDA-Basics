﻿
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>



__global__ void unique_idx_calc_threadIdx(int* input) {

	int tid = threadIdx.x;
	printf("threadIdx : %d, value : %d \n", tid, input[tid]);
}

__global__ void unique_gid_calculation(int * input){
	int tid = threadIdx.x;
	int offset = blockIdx.x * blockDim.x;
	int gid = tid + offset; // global index
	printf("blockIdx.x : %d, threadIdx : %d, gid : %d value : %d \n"
		,blockIdx.x, tid, gid, input[gid]);



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
	cudaMalloc((void**)& d_data, array_byte_size);
	cudaMemcpy(d_data, h_data, array_byte_size, cudaMemcpyHostToDevice);

	dim3 block(16);
	dim3 grid(1);

	dim3 block2(8);
	dim3 grid2(2);
	
	dim3 block3(4);
	dim3 grid3(4);

	unique_idx_calc_threadIdx <<< grid, block >>> (d_data);
	unique_idx_calc_threadIdx <<< grid2, block2 >>> (d_data);
	unique_gid_calculation << < grid3, block3 >> > (d_data);
	cudaDeviceSynchronize();

	cudaDeviceReset();
	return 0;
}

