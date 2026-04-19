.data 

.text
addi $t0, $0, 5  #size of array = $t0 = 5
addi $s0, $0, 12 #array base address = $s0 = 12
addi $t1, $0, 0  #$t1 = i = 0
loop_0 : beq $t1, $t0, else_0
         add $t2, $t1, $t1 # $t2 = 2*$t1 = 2*i 
         add $t3, $t2, $t2 # $t3 = 2*$t2 = 4*i
         add $t4, $t3, $s0 # $t4 = eff_addr = base + offest
         sw $t2, 0($t4)
         addi $t1, $t1, 1 # i++ 
         j loop_0
else_0 : addi $a0, $s0, 0 # $a0 = base address
       addi $a1, $t0, 0 # $a1 = size of array
       jal sum
       addi $s1, $v0, 0
       j done
sum : addi $t0, $0, 0 # $t0 = i
      addi $t1, $0, 0 # $t1 = result
      loop_1 : beq $a1, $t0, else_1
               add $t2, $t0, $t0 # $t2 = 2*i 
               add $t2, $t2, $t2 # $t2 = 4*i 
               add $t2, $t2, $a0 # $t2 = base_address + 4*i
               lw $t3, 0($t2) # load a[i] into $t3
               add $t1, $t1, $t3 # result += a[i]
               addi $t0, $t0, 1 # i+=1 
               j loop_1
        else_1 : addi $v0, $t1, 0
                 jr $ra
done :
