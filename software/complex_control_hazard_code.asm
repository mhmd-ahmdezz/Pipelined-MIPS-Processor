.data

.text
addi $t0 , $0 , 10
#addi $t1 , $0 , 11
#addi $t1 , $0 , 12
#addi $t1 , $0 , 13
#addi $t1 , $0 , 14
#addi $t1 , $0 , 15
addi $s0 , $0 , 10
beq  $s0 , $t0 , loop
addi $t1 , $0 , 20 
addi $t2 , $0 , 20 
addi $t3 , $0 , 20 
addi $t4 , $0 , 20 
loop: add $s2 , $s0 , $t0 
