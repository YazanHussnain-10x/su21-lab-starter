OUTPUT_ARCH("riscv")
ENTRY(main)

SECTIONS
{
    /* Set the starting address of the text section */
    . = 0x80000000;

    .text :
    {
        *(.text)
    }

    /* Align the following section to a 4KB boundary */
    . = 0x80001000;

    /* .data section contains initialized data */
    .data :
    {
        *(.data)
    }
  . = ALIGN(0x1000);
    /* .text.init section contains code that should be executed before main */
    .text.init :
    {
        *(.text.init)
    }

    /* Align the following section to a 4KB boundary */
    . = ALIGN(0x1000);

    /* .tohost section contains the tohost address for the exit system call */
    .tohost :
    {
        *(.tohost)
    }

    /* Align the following section to a 4KB boundary */
    . = ALIGN(0x1000);

    /* .text section contains the main code */

    /* .data.string section contains initialized string data */
    .data.string :
    {
        *(.data.string)
    }

    /* .bss section contains uninitialized data */
    .bss :
    {
        *(.bss)
    }

    /* Set the _end symbol to the current address */
    _end = .;
}
