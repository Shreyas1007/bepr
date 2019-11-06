#include<iostream>
#include<cstdio>
using namespace std;
int calcCost(int arr[],int N){
 int c=0;
 for(int i=0;i<N;i++){
  for(int j=i+1;j<N;j++) if(arr[j]<arr[i]) c++;
 }
 return c;
}

void swap(int arr[],int i,int j){
 int tmp=arr[i];
 arr[i]=arr[j];
 arr[j]=tmp;
}

int main(){
 int N;
 scanf("%d",&N);
 int arr[N];
 for(int i=0;i<N;i++) scanf("%d",&arr[i]);
 int bestCost=calcCost(arr,N),newCost,swaps=0;;
 while(bestCost>0){
  for(int i=0;i<N-1;i++){
   swap(arr,i,i+1);
   newCost=calcCost(arr,N);
   if(bestCost>newCost){
    printf("After swap %d: \n",++swaps);
    for(int i=0;i<N;i++) printf("%d ",arr[i]);
    printf("\n");
    bestCost=newCost;
   }
   else swap(arr,i,i+1);
  }
 }
 printf("Final Ans\n");
 for(int i=0;i<N;i++) printf("%d ",arr[i]);
 printf("\n");
 return 0;
}
