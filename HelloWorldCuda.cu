
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

cudaError_t addWithCuda(int *c, const int *a, const int *b, unsigned int size);

__global__ void helloCuda(){

    printf("Hello World With CUDA!\n");
}

__global__ void helloCuda2() {

    printf("Hello World With CUDA 20 Times!\n");
}

__global__ void helloCuda3() {

    printf("Hello World With CUDA 16 Times!\n");
}

__global__ void helloCuda4() {

    printf("Hello World With CUDA Special\n");
}

int main(){

    int nx, ny;
    nx = 16; ny = 4;

    dim3 block(4);
    dim3 grid(4);

    dim3 block2(8,2);
    dim3 grid2(nx /block.x, ny/block.y);

    helloCuda << <1, 1 >> > ();
    helloCuda2 << <1, 20 >> > ();
    helloCuda3 << <grid,block >> > ();
    helloCuda4 << <grid2, block2 >> > ();
    cudaDeviceSynchronize();
    cudaDeviceReset();
    return 0;
}

