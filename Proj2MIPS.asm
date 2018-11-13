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
			lbu $t1, 0($a0) #load the character into t1
			bge $t1, $a1, tooLong
			beqz $t1, exit
			beq $t1,' ',loop #if it is space, the go to the top of the loop
            		
            		addi $t0, $t0, 1
   			addi $a0, $a0, 1
            
       			j loop
		exit:
     			li $v0, 11        # Print chars
    			la $a0, 69        # @ (64)
    			syscall
    			j end
    	