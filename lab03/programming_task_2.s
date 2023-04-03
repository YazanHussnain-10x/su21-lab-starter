.text                      # Start of .text section
.globl main                # Declare main function as global

main:                      # Start of main function
    li a0, 5               # Load 5 into a0 register
    li a3, 10              # Load 10 into a3 register
    jal ra, dataArray      # Jump to dataArray function
    jal end                # Jump to end label

dataArray:                 # Start of dataArray function
    addi sp, sp, -48       # Allocate 48 bytes of space on stack
    sw ra, 44(sp)          # Store return address on stack
    sw s0, 40(sp)          # Store s0 on stack
    li s0, 0               # Initialize s0 to 0

    loop:                  # Start of loop
        bge s0, a3, exit_dataArray  # Exit loop if s0 >= 10
        jal ra, compare    # Jump to compare function
        slli t1, s0, 2     # Calculate memory offset for array element
        add t2, sp, t1     # Calculate address of array element
        mv t3, a0          # Store the value of a0 into t3
        addi a1, a2, 0     # Copy array element to a0 for printing
        addi a0, x0, 1     # Prepare for print integer syscall
        ecall              # Invoke print integer syscall
        addi a1, x0, ' '   # Load space character into a1 register
        addi a0, x0, 11    # Prepare for print char syscall
        ecall              # Invoke print char syscall to print space
        mv a0, t3          # Restore a0 value
        sw a2, 0(t2)       # Store compare result in array
        addi s0, s0, 1     # Increment loop counter s0
        jal loop           # Jump back to loop start

    exit_dataArray:        # Exit loop
        lw s0, 40(sp)      # Restore s0 from stack
        lw ra, 44(sp)      # Restore return address from stack
        addi sp, sp, 48    # Deallocate space on stack
        jr ra              # Return from function

compare:                  # Start of compare function
    addi sp, sp, -4        # Allocate 4 bytes of space on stack
    sw ra, 0(sp)           # Store return address on stack
    jal ra, subtract      # Jump to subtract function
    bge a2, x0, compare_if # If a2 >= 0, jump to compare_if
    li a2, 0               # Set a2 to 0 if a2 < 0
    jal compare_end        # Jump to end of compare function
compare_if:               # Start of compare_if
    li a2, 1               # Set a2 to 1
compare_end:              # End of compare function
    lw ra, 0(sp)           # Restore return address from stack
    addi sp, sp, 4         # Deallocate space on stack
    jr ra                  # Return from function

subtract:                 # Start of subtract function
    sub a2, a0, s0         # Subtract s0 from a0 and store result in a2
    jr ra                  # Return from function

end:                      # Start of end function
    addi a1, x0, '\n'   # Load in ascii code for newline
    addi a0, x0, 11
    ecall

