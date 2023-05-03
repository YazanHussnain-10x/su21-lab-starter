li t2, 29
li t2, -214
li t2, -2999
li t2, 0xABCDE000
li t2, 0xEDCBA123
li t2, 0xEEEEEFAB

ble t0, t1, target # if to <= t1 then target
target:
add x0, x0, x0