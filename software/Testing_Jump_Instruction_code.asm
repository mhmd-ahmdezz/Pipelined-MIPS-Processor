.data

.text 
addi $s0 , $0  , 10
addi $s1 , $0  , 10
addi $s2 , $0  , 10
j loop
add $t0 , $s0 , $s1
add $t0 , $t0 , $t0
loop : add $t0 , $s0 , $s1