
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#define N 2048
#define THREADS_PER_BLOCK 50

__global__ void add(int *a, int *b, int *c)
{

	printf("threadid No : %d\n",threadIdx.x);
	printf("blockid No : %d\n",blockIdx.x);
	printf("blockdim No : %d\n",blockDim.x);

	int index = threadIdx.x + blockIdx.x * blockDim.x;
	

	printf("Index No : %d\n",index);

	c[index] = a[index] + b[index];

}

int main()
{
	int a[N],b[N],c[N];
	int *dev_a, *dev_b, *dev_c;
	int size = N * sizeof(int);


	cudaMalloc((void **)&dev_a,size);
	cudaMalloc((void **)&dev_b,size);
	cudaMalloc((void **)&dev_c,size);

	//FILL data
	for(int i=0;i<10;i++)
	{
		a[i]=i;
		b[i]=i;
	}

	cudaMemcpy(dev_a,a,size,cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b,b,size,cudaMemcpyHostToDevice);

	add<<<N/THREADS_PER_BLOCK,THREADS_PER_BLOCK>>>(dev_a,dev_b,dev_c);

	cudaMemcpy(c,dev_c,size,cudaMemcpyDeviceToHost);

	for(int i=0;i<10;i++)
	{
		printf("\n %d + %d --> addition is :%d \n\n",a[i],b[i],c[i]);
	}

	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);

	return 0;

}