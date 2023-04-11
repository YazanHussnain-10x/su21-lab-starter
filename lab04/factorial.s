.globl factorial

.data
n: .word 9
result: .word 0

.text
.globl main
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    la a1, result
    sw a0, 0(a1)
    lw a1, 0(a1)
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi sp, sp, -8
    sw ra, 0(sp)
    sw a0, 4(sp)

    li t2, 1
    beq a0, t2, base_case

    addi a0, a0, -1
    jal ra, factorial

    add t1, a0, x0
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    mul a0, a0, t1
    jr ra

base_case:
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 8
    li a0, 1
    jr ra

