.data

.text
addi $s0 , $0  , 10
addi $s1 , $0  , 10
addi $s2 , $0  , 10
addi $s3 , $0  , 10
addi $s4 , $0  , 10
beq  $s0 , $s1 , l1
sub  $s2 , $s1 , $s0
sub  $s3 , $s4 , $s3
l1 : add $s2 , $s0 , $s1