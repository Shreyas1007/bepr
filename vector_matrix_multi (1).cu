
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include<iostream>

using namespace std;
#define N 3
#define NN 50
#define BLOCKSIZE 10
#define __CUDACC__
#include <device_functions.h>


__global__ void compute(int *a, int *b, int *c, int rowsize)
{
		int tidx = blockIdx.x*blockDim.x + threadIdx.x;
        int tidy = blockIdx.y*blockDim.y + threadIdx.y;
        int tindex=tidx+gridDim.x*BLOCKSIZE*tidy;
		 if(tindex<rowsize)
		 {
			 int i;int m=tindex*rowsize;
				c[tindex]=0.00;
			
				for(i=0;i<N;i++)
			  c[tindex]+=a[m+i]*b[i];
		}

    __syncthreads();
			cout<<"\n tidx :"<<tidx;
			cout<<"\n tidy :"<<tidy;
			cout<<"\n tindex :"<<tindex;

}

int main()
{
	int vector[N],matrix[N][N],result[N];
	int *dev_vector, *dev_matrix, *dev_c;
	int size = NN*sizeof(int);

	cout<<"\n Enter 3 element :";
	for(int i=0;i<3;i++)
	{
		cin>>vector[i];		
	}
	cout<<"\n Enter 3x3 matrix element:";
	for(int i=0;i<3;i++)
	{
		for(int j=0;j<3;j++)
		{
				cin>>matrix[i][j];
		}
	}

	cout<<"\n Entered element:";
	for(int i=0;i<3;i++)
	{    
		cout<<"\n";
		for(int j=0;j<3;j++)
		{
				cout<<matrix[i][j];
				cout<<"\t";
		}
		cout<<"\t \t";
	}
	cudaMalloc((void **)&dev_vector,size);
	cudaMalloc((void **)&dev_matrix,size);
	cudaMalloc((void **)&dev_c,size);

	cudaMemcpy(dev_vector,vector,size,cudaMemcpyHostToDevice);
	cudaMemcpy(dev_matrix,matrix,size,cudaMemcpyHostToDevice);

	compute<<<N,N>>>(dev_vector,dev_matrix,dev_c,N);

	cudaMemcpy(result,dev_c,size,cudaMemcpyDeviceToHost);
	
	for(int j=0;j<3;j++)
	{
		cout<<"result"<<result[j];
		cout<<"\t";
	}

	return 0;
}