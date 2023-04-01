#include <stdio.h>
#include <stdlib.h>

int odd_occur(int *arr, int size)
{
    int result = *arr, i;
    for(i = 1; i < size; i++)
    {
        result ^= *(arr + i);
    }
    return result;
}

int main(int argc, char *argv[])
{
    int arr[] = {12, 12, 14, 90, 14, 14, 14};
    printf("Odd-Occuring element is: %d\n", odd_occur(arr, 7));
}