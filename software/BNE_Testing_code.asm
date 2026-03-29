.data 
.text 
addi $t0 , $0 , 10
addi $t1 , $0 , 20
bne $t0 , $t1 , else
add $s0 , $t0 , $t1
j done
else : sub $s0 , $t1, $t0
done :