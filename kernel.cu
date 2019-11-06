#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <ctime>
#include <stdio.h>
#include <iostream>
#include <math.h>

using namespace std;


__global__ void MulKernel(int *c, const int *a, const int *b, const int P)
{
    int tempsum=0;
    int row = blockIdx.y*blockDim.y + threadIdx.y;
    int col = blockIdx.x*blockDim.x + threadIdx.x;
    if (row < P && col < P){
        for (int i = 0; i < P; i++){
            tempsum += a[row*P + i] * b[i*P + col];
        }
        c[row*P + col] = tempsum;
    }
}


int main()
{

    srand(time(NULL));
    int N = 16;
    int SIZE = N*N;

    int *h_a = new int[SIZE];
    int *h_b = new int[SIZE];
    int *h_c = new int[SIZE];

    for (int i = 0; i < SIZE; i++) {
            h_a[i] = rand() % 1000;
            h_b[i] = rand() % 1000;
    }
    cout << "First values " << h_a[0] << " " << h_b[0] << endl;
    int *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, sizeof(int)*SIZE);
    cudaMalloc(&d_b, sizeof(int)*SIZE);
    cudaMalloc(&d_c, sizeof(int)*SIZE);

    cout << "Second values " << h_a[0] << " " << h_b[0] << endl;

    cudaMemcpy(d_a, h_a, sizeof(int)*SIZE, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, sizeof(int)*SIZE, cudaMemcpyHostToDevice);

    cout << "Third values " << h_a[0] <<" "<< h_b[0] << endl;

    MulKernel <<<1, dim3(N,N) >>>(d_c, d_a, d_b, N);

    cudaMemcpy(h_c, d_c, sizeof(int)*SIZE, cudaMemcpyDeviceToHost);
    cudaMemcpy(h_a, d_a, sizeof(int)*SIZE, cudaMemcpyDeviceToHost);
    cudaMemcpy(h_b, d_b, sizeof(int)*SIZE, cudaMemcpyDeviceToHost);

    for (int i = 0; i < 5; i++){
        cout << h_c[i] << "=" << h_a[i] << h_b[i] << endl;
    }
    cout << h_c[1] << endl;
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    return 0;
}