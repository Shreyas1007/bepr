
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<iostream>
#include <stdio.h>
#include<math.h>
using namespace std;
#define N 20

__global__ void max(int *a, int *b)
{
	*b=a[0];

	if(*a > *b)
	{
		*b = *a;
	}

}

__global__ void min(int *a, int *b)
{
	*b=a[0];

	if(*a < *b)
	{
		*b = *a;
	}

}

__global__ void avg(int *a,int *b)
{
	*b = *b + *a;
	
}


int main() 
{ 
	int ch,size=0,a[N],max,min,avg=0;
	char ans;
	float sum = 0.0, mean, standardDeviation = 0.0,varsum=0.0;
	    
	int *dev_a,*dev_b; //GPU
	int size = N*sizeof(int);

	cout<<"\n Enter Size of Vector";
	cin>>size;
	cout<<"\n Enter Element :";
	for(int i=0;i<size;i++)
	{

		cin>>a[i];
	}
	
		cudaMalloc((void **)&dev_a,size);
		cudaMalloc((void **)&dev_b,size);
		dev_b=&a[0];
		cudaMemcpy(dev_a,a,size,cudaMemcpyHostToDevice);
									

	do
	{
		cout<<"\n -----MENU-----";
		cout<<"\n 1.Find Max number from vector";
		cout<<"\n 2.Find Min number from vector";
		cout<<"\n 3.Arithmetic Mean ";
		cout<<"\n 4.Standard Deviation";
		cout<<"\n 5.exit";
		cout<<"\n Enter ur choice:";
		cin>>ch;
		switch(ch)
		{

			case 1:
						
				    //------------------------GPU CODE--------------

					max<<<1,1>>>(dev_a,dev_b);

					cudaMemcpy(&max,dev_b,size,cudaMemcpyDeviceToHost);

					//----------------------------------------------
					cout<<"\n Max element in Vector is :"<<max<<"\n";

					break;
			case 2:
					 //------------------------GPU CODE--------------

					min<<<1,1>>>(dev_a,dev_b);

					cudaMemcpy(&min,dev_b,size,cudaMemcpyDeviceToHost);

					//----------------------------------------------
					cout<<"\n Min element in Vector is :"<<min<<"\n";
					break;
			case 3:
					

					avg<<<1,1>>>(dev_a,dev_b);

					cudaMemcpy(&sum,dev_b,size,cudaMemcpyDeviceToHost);

					avg = sum/size;

					cout<<"\n Arithmetic Mean is :"<<avg<<"\n";
					break;
			case 4:  //summation (vector - (Mean))sqr/n-1
					
				standardDeviation=0.0;
				sum=0;

					for(int i=0; i<size; i++)
					{
						sum	= sum + a[i];
					}
					mean = sum/size;
				
					for(int i=0; i<size; i++)
					{
						float  diff = a[i] - mean;
						 varsum = varsum + pow(diff,2);
					}

					float  variance = varsum/size;

					cout<<"\n Variance is :"<<variance;

					standardDeviation = sqrt(variance);
					
					cout<<"\n Std Deviation is :"<<standardDeviation<<"\n"; 

					break;

			case 5:
					cout<<"\n Thanks\n\n\n";
					exit(0);
					break;
		}
		cout<<"\n Do u want to continue ?";
		cin>>ans;
	}while(ans=='y'||ans=='Y');


    return 0; 
} 