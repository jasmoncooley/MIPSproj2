.data
	myArray: .word 5:10
	newLine: .asciiz "\n"
	str:
		.space 16

.text
	main: 
	
	li $v0, 8
	la $a0, str
	li $a1, 16
	syscall
	
	li $v0, 4
	la $a0, str
	syscall
  
  	addi $t0, $zero, 0
  	while:
  	beq $t0, 40, exit
  	lw $t6, myArray($t0)
  	addi $t0, $t0, 4
  	li $v0, 1
  	move $a0, $t6
  	syscall
  
  	li $v0,4
  	la $a0, newLine
  	syscall
  
  	j while
  
 exit:
 	li $v0,10
 	syscall