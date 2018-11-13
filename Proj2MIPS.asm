.data
	str: .space 10
	newLine: .asciiz "\n"
	tooLongMessage: .asciiz "too long"
	notInRange: .asciiz "not in range"

.text
	main:
	
		li $v0, 8 #read in integer
		la $a0, str
		li $a1, 65 #this is A
		syscall

		loop: