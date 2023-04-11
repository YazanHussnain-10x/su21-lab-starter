/*
 * Custom linker script for RISC-V
 * Defines the memory layout and section placement for an application
 */

/* Define the memory regions */
OUTPUT_ARCH( "riscv" )
MEMORY
{
    /* Define the RAM region */
    ram (rwx) : ORIGIN = 0x80000000, LENGTH = 16K
}

/* Define the entry point */
ENTRY(main)

/* Define the sections */
SECTIONS
{
    /* .text section */
    .text :
    {
        /* Place the text section at the beginning of RAM memory */
        *(.text)
    } > ram

    /* .data section */
    .data :
    {
        /* Place the data section after the text section */
        *(.data)
    } > ram + 0x1000

    /* .bss section */
    .bss :
    {
        /* Place the uninitialized data section after the data section */
        *(.bss)
    } > ram + 0x2000
}

/* End of linker script */
