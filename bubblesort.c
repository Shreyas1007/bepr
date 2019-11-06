

#include<stdio.h>
#include<stdlib.h>
#include<omp.h>


int main()
{
	
	int arr[10], limit,i=0,j=0,temp=0;
	
	
	printf("\n Enter limit of array:");
	scanf("%d",&limit);
	
	//get data
	printf("\n Enter Data:");
	#pragma omp parallel
	for(i=0;i<limit;i++)
	{	
		scanf("%d\n",&arr[i]);
	}
	
	printf("\n Entered data is :");

	for(i=0;i<limit;i++)
	{
		printf("\n %d\n\n",arr[i]);

	}

	#pragma omp parallel for private(temp)
	 for (i = 0; i < limit-1; i++)      
      	{
		 printf("Data = %d  , Thread no. : %d\n",arr[i],omp_get_thread_num()); 
  		  // Last i elements are already in place  
    		for (j = 0; j < limit-i-1; j++) 
		{ 
			
        		if (arr[j] > arr[j+1])  
			{
				int temp = arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = temp;
				
			}
  		}
	}

	printf("\n sorted data is :");

	for(i=0;i<limit;i++)
	{
		printf("\n %d\n\n",arr[i]);

	}


	
return 0;
}

