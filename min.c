#include <stdio.h>
#include <omp.h>


int main()
{
    double arr[10];
    omp_set_num_threads(4);
    double min_val=0.0;
    int i;
    for( i=0; i<10; i++)
        arr[i] = 2.0 + i;

    #pragma omp parallel for reduction(min : min_val)

    for( i=0;i<10; i++)
    {
        printf("thread id = %d and i = %d", omp_get_thread_num(), i);
        
	if(arr[i] < min_val)
        {
            min_val = arr[i];  
        }
    }
  
    printf("\nmin_val = %f", min_val);
}
