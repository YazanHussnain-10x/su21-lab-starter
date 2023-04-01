#include <stdio.h>
#include <stdint.h>

#define CSR_VAL 0x8000abcd00001234UL

#define ADDRESS 0x5300f000U

unsigned long int my_csr = CSR_VAL;

unsigned long int test;

int main(void)

{

  my_csr |= (0x01);

  my_csr &= ~(0x04);

  my_csr = (my_csr & ~(0xff << 8)) | (0xee << 8);

  my_csr = (my_csr & ~((uint64_t)0xffff << 16)) | (((ADDRESS >> 12) & 0xffff) << 16);

  printf("0x%lx \n", my_csr);

	return 0;

}
