.import lotsofaccumulators.s

.data
inputarray: .word 0,1,2,3,4,5,6,7,0
check_reg: .word 0,0

TestPassed: .asciiz "Test Passed!"
TestFailed: .asciiz "Test Failed!"

.text
# Tests if the given implementation of accumulate is correct.
#Input: a0 contains a pointer to the version of accumulate in question. See lotsofaccumulators.s for more details
#
#
#
#The main function currently runs a simple test that checks if accumulator works on the given input array. All versions of accumulate should pass this.
#Modify the test so that you can catch the bugs in four of the five solutions!
main:
    la a0 inputarray

    li s0, 456
    la t0, check_reg
    sw s0, 0(t0)
    sw sp, 4(t0)

    jal accumulatorfour

    la t0, check_reg
    lw t1, 0(t0)
    bne s0, t1, Fail
    lw t1, 4(t0)
    bne sp, t1, Fail

    li t0 28
    beq a0 t0 Pass
Fail:
    la a0 TestFailed
    jal print_string
    j End
Pass:
    la a0 TestPassed
    jal print_string
End:
    jal exit

print_int:
	mv a1 a0
    li a0 1
    ecall
    jr ra
    
print_string:
	mv a1 a0
    li a0 4
    ecall
    jr ra
    
exit:
    li a0 10
    ecall