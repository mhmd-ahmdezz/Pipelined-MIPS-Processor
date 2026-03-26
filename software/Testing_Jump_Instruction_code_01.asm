.data 

.text 
addi $s0 , $0  , 10 
addi $s1 , $0  , 20
#addi $s2 , $0  , 30
#add  $s0 , $s1 , $s2
j loop
addi $t0 , $0 , 20
sub $s0 , $t0 , $s0
#loop : addi $t2 , $0  , 100
loop : add  $s2 , $s1 , $s0
       sub  $s0 , $s1 , $s0