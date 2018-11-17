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
		addi $t1, $t1, 10  #Load line feed char
		syscall

		LengthSpaceLoop:
			lbu $t1, 0($a0) #load the character into t1
			beqz $t1, empty
			beq $t2, $t1, done   #End when line feed is detected
			beq $t1,' ',skipSpace #if it is space then go to the next value
            		addi $t0, $t0, 1 #count the amount of characters
   			addi $a0, $a0, 1
       			j loop
		exit:
    			j end
    		tooLong:
			li $v0, 4
			la $a0, tooLongMessage
			syscall
			j end
		empty:
			li $v0, 4
			la $a0, emptyMessage
			syscall
			j end
		skipSpace:
			addi $a0,$a0,1
			sub $t0, $t0, 1 #if we skip a space, we want to subtract that character frorm our length
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