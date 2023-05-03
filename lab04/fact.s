.text              
.globl main
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    la a1, result
    
    j write_tohost

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

write_tohost:
    li x1, 1
    sw x1, tohost, t5
    j write_tohost

.data 
n: .word 9
result: .word 0
.align 3

.section ".tohost","aw",@progbits;                            

.align 4; .global tohost; tohost: .dword 0;                     

.align 4; .global fromhost; fromhost: .dword 0; 
