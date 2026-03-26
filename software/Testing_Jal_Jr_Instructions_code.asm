.data

.text
addi $a0, $0 , 10
addi $a1, $0 , 20
jal sum
addi $s1, $0 , 10
add  $s2, $s1, $v0
j done
sum : add $v0, $a0, $a1
      jr $ra
done :