# fib_iter: tinh F(n) bang vong lap
# Tham so : $a0 = n    Tra ve : $v0 = F(n)
# Thanh ghi: $t0-$t3 (thu tuc la)
.data
 n: .word  20 
.text
main: 
  lw $a0,n  
  jal fib_rec
  move $s0, $v0
  li $v0, 1
  move $a0, $s0 
  syscall
  li $v0, 10
  syscall
  
fib_rec:
  slti $t0, $a0, 2 
  bne $t0, $zero, fib_base
  addi $sp, $sp, -16
  sw $ra, 12($sp)
  sw $a0, 8($sp)
  addiu $a0, $a0, -1
  jal fib_rec 
  sw $v0, 4($sp)
  lw $a0, 8($sp)
  addiu $a0, $a0, -2
  jal fib_rec
  lw $t1, 4($sp)
  addu $v0, $t1, $v0
  lw $ra, 12($sp)
  addiu $sp, $sp, 16
  jr $ra
fib_base:
  move $v0, $a0
  jr $ra
  