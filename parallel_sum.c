
#include<stdio.h>
#include<omp.h>


#include <stdio.h>
#define MAX_SIZE 100

int main()
{
    int arr[MAX_SIZE];
    int i, n, sum=0;

    /* Input size of the array */
    printf("Enter size of the array: ");
    scanf("%d", &n);

    /* Input elements in array */
    printf("Enter %d elements in the array: ", n);
    for(i=0; i<n; i++)
    {
        scanf("%d", &arr[i]);
    }

    /*
     * Add each array element to sum
     */
    #pragma omp parallel
    for(i=0; i<n; i++)
    {
	printf("\n thread : %d\n",omp_get_thread_num());

        sum = sum + arr[i];
    }


    printf("Sum of all elements of array = %d\n\n", sum);

    return 0;
}
