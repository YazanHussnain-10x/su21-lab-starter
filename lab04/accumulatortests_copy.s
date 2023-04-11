.import lotsofaccumulators.s

.data
inputarray: .word 1,2,3,4,5,6,7,0

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
    jal accumulatorone
    li t0 28
    beq a0 t0 Pass1
Fail1:
    la a0 TestFailed
    jal print_string
    j End1
Pass1:
    la a0 TestPassed
    jal print_string
End1:
    jal exit1

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
    
exit1:
    li a0 10
    ecall

la a0 inputarray
jal accumulatortwo
li t0 28
beq a0 t0 Pass2
Fail2:
    la a0 TestFailed
    jal print_string
    j End2
Pass2:
    la a0 TestPassed
    jal print_string
End2:
    li a0 10
    ecall
    la a0 inputarray
    jal accumulatorthree
    li t0 28
    beq a0 t0 Pass3
Fail3:
    la a0 TestFailed
    jal print_string
    j End3
Pass3:
    la a0 TestPassed
    jal print_string
End3:
    li a0 10
    ecall
    la a0 inputarray
    jal accumulatorthree
    li t0 28
    beq a0 t0 Pass4
Fail4:
    la a0 TestFailed
    jal print_string
    j End4
Pass4:
    la a0 TestPassed
    jal print_string
End4:
    li a0 10
    ecall
    la a0 inputarray
    jal accumulatorthree
    li t0 28
    beq a0 t0 Pass5
Fail5:
    la a0 TestFailed
    jal print_string
    j End5
Pass5:
    li a0 10
    ecall
    la a0 TestPassed
    jal print_string
End5: