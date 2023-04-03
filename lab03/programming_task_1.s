.data
b:
    .word 12           # Uninitialized space for b, becasue is not initialize in C code
a:
    .word 7             # value variable a
.text
addi s0, x0, 0          # varibale i
addi a0, x0, 3          # 3 is store to check loop condition
la s1, a                # Store address of a
lw s1, 0(s1)            # Store value of a in s1
la s2, b                # Store address of b in s2

loop:
    bge s0, a0, exit    # if s0 >= a0 then exit
    slli t0, s0, 2      # Multiply i by 4 (shift left by 2 bits) to get offset in bytes
    add t1, s2, t0      # Calculate the addres of b[i]
    mul t2, s1, s0      # Calculate (i * a)
    add t2, t2, s1      # Calculate a + (i * a)
    mv t3, a0
    addi a1, t2, 0       # Load t2 into a0 for printing
    addi a0, x0, 1
    ecall                # Invoke print system call
    addi a1, x0, ' '    # a0 gets address of string containing space
    addi a0, x0, 11     # Prepare for print char syscall
    ecall
    mv a0, t3
    sw t2, 0(t1)        # Store data in b[i]
    addi s0, s0, 1      # Increment i
    jal loop            # jump back to check condition of loop
exit:
    addi a1, x0, '\n'   # Load in ascii code for newline
    addi a0, x0, 11
    ecall