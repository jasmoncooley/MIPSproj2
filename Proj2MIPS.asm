.data
	user: .space 10
	newLine: .asciiz "\n"
	emptyMessage: .asciiz "nothing is here"
	tooLongMessage: .asciiz "too long"
	notInRange: .asciiz "not in range of base 32"

.text
	main:
	
		li $v0, 8 #read in integer
		la $a0, user
		li $a1, 65 #this is A
		syscall

		LengthSpaceLoop:
			lbu $t1, 0($a0) #load the character into t1
			bge $t1, $a1, tooLong
			beqz $t1, exit
			beq $t1,' ',skipSpace #if it is space then go to the next value
            		#addi $t0, $t0, 1
   			addi $a0, $a0, 1
       			j loop
		exit:
     			li $v0, 11        # Print chars
    			la $a0, 69        # @ (64)
    			syscall
    			j end
    		tooLong:
			li $v0, 4
			la $a0, tooLongMessage
			syscall
			j end
		skipSpace:
			addi $a0,$a0,1
			j LengthSpaceLoop
		range1:
			li $v0, 4
			la $a0, tooLongMessage
			syscall	
		lessthan:
			ble $t1,$a1, notInRange
     end:
     li $v0, 10			
     syscall