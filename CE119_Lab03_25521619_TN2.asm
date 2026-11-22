.data
msg_str: .asciiz "mot lenh jr  tra quyen ve noi goi"
msg_pipe: .asciiz "|"
.text
.globl main 
main:
    la $a0, msg_str 
    jal reverse_words
    la $a0, msg_str
    jal print
    li $v0, 10 
    syscall
print:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, 0($sp)
    move $s0, $a0
    
    li $v0, 4
    la $a0, msg_pipe
    syscall
    
    move $a0, $s0
    li $v0, 4
    syscall
    
    li $v0, 4
    la $a0, msg_pipe
    syscall
    
    lw   $s0, 0($sp)
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    jr   $ra
strlen:
    move $t0, $a0 
    li $v0, 0
  count:
    lbu $t1, 0($t0)
    beq $t1, $zero, done
    addi $v0, $v0, 1
    addi $t0, $t0, 1
    j count
  done:
    jr $ra
rev_range:
    move $t0, $a0
    move $t1, $a1
  loop:
    bgeu $t0, $t1, loop_done
    lbu $t2, 0($t0)
    lbu $t3, 0($t1)
    sb $t3, 0($t0)
    sb $t2, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, -1
    j loop
  loop_done:
    jr $ra
reverse_words:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s0, 12($sp)
    sw $s1, 8($sp)
    sw $s2, 4($sp)
    sw $s3, 0($sp)
    move $s0, $a0
    
    move $a0, $s0
    jal strlen
    move $s1, $v0
    
    move $a0, $s0
    addu $a1, $s0, $s1
    addi $a1, $a1, -1
    jal rev_range
    
    li $s2, 0
    li $s3, 0
  loop_word:
    bgt $s3, $s1, end
    addu $t0, $s0, $s3
    lbu $t1, 0($t0)
    
    li $t2, 32
    beq $t1, $t2, reverse
    beq $t1, $zero, reverse
    addi $s3, $s3, 1
    j loop_word
  reverse:
    addu $a0, $s0, $s2
    addu $a1, $s0, $s3
    addi $a1, $a1, -1
    jal rev_range
    
    addi $s2, $s3, 1
    addi $s3, $s3, 1
    j loop_word
  end:
    lw $s3, 0($sp)
    lw $s2, 4($sp)
    lw $s1, 8($sp)
    lw $s0, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra
   