.data

.text

#addi $s1 , $0 , 10
#sw $s1, 8($0)
#addi $s2 , $0 , 10
#addi $s3 , $0 , 10


addi $s1 , $0 , 10
addi $s2 , $0 , 0
sw $s1 , 8($0)
lw $s3 , 8($0)
and $t0, $s3, $s2 
