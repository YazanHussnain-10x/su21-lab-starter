#include <stdio.h>
#include <assert.h>

#define Max_val 0x8FFFFFFF

int main(){

    int x = 0xFFFFFFFF;

    static_assert(x <= __INT32_MAX__, "Max val should be less then INT32 MAX");
}