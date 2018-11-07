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
  
