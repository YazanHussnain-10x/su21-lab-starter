#include <stdio.h>

int main()
{
    typedef char *charp;
	char x = '5';
    const charp P = &x;

	printf("%p\n", P);
	//char y ='5';
	//P = &y;
	//printf("%p\n", P);
}

