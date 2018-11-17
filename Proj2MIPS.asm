.data
	newLine: .asciiz "\n"
	emptyMessage: .asciiz "nothing is here"
	tooLongMessage: .asciiz "too long"
	notInRange: .asciiz "not in range of base 32"
	user: .space 50

.text
    main:
		li $v0, 8 #read in integer
		la $a0, user
		li $a1, 51
		syscall

		LengthSpaceLoop:
		li $t8, 32  #Load space char
		li $t1, 10 #new line
		li $t5, 4
		lb $t2, 0($a0) #load the character into t1
		beq $t8, $t2, skipSpace   #End when line feed is detected
		#move $t4, $a0
		#beq $t1,$t2, lengthCheck #if it is space then go to the next value
		beqz $t2, empty
            	addi $t0, $t0, 1 #count the amount of characters
   		addi $a0, $a0, 1
   		beq $t0, $t5, length
       		j LengthSpaceLoop
       		
		empty:
		li $v0, 4
		la $a0, emptyMessage
		syscall
		j end
		
		length:
		beq $t1, $t2, lengthCheck
		#move $t4, $a0 #store content of a0
		slti $t3, $t0, 5      #Check that count is less than 5
		beqz $t3, tooLong #Branch to length error if length is 5 or more
		#move $a0, $t4
		j checkString
		
		lengthCheck:
		beqz $t0, emptyMessage   #Branch to null error if length is 0
		#move $a0, $t4
		j length
		
		skipSpace:
		addi $a0,$a0,1
		#sub $t0, $t0, 1 #if we skip a space, we want to subtract that character frorm our length
		move $t4, $a0
		j LengthSpaceLoop
		
		range1:
		li $v0, 4
		la $a0, notInRange
		syscall	
		tooLong:
		li $v0, 4
		la $a0, tooLongMessage
		syscall
		j end
			
		checkString:
		lb $t5, 0($a0)
		beqz $t5, conversion  #End if null character is reached
		beq $t5, $t1, conversion  #End loop if NL is detected
		slti $t6, $t5, 48    #Check if less than 0 
		bne $t6, $zero, baseError
		slti $t6, $t5, 58    #Check if less than 9 
		bne $t6, $zero, Increment
		slti $t6, $t5, 65    #Check if less than A 
		bne $t6, $zero, baseError
		slti $t6, $t5, 87    #Check if less than W
		bne $t6, $zero, Increment
		slti $t6, $t5, 97    #Check if less a
		bne $t6, $zero, baseError
		slti $t6, $t5, 119   #Check if less than w
		bne $t6, $zero, Increment
		bgt $t5, 118, baseError   #Check if is greater than v

		Increment:
		addi $a0, $a0, 1
		j checkString

		baseError:
		li $v0, 4
		la $a0, notInRange #not in correct range with base 32
		syscall
		j end
			
		conversion:
		move $a0, $t4
		addi $t7, $t7, 0  #decimal num is zero
		add $s0, $s0, $t0
		addi $s0, $s0, -1	
		li $s3, 3
		li $s2, 2
		li $s1, 1
		li $s5, 0
			
		convertString:
		lb $s4, 0($a0)
		beqz $s4, decimalnum
		beq $s4, $t1, decimalnum
		slti $t6, $s4, 58
		bne $t6, $zero, zeroToNine
		slti $t6, $s4, 89
		bne $t6, $zero, A2V
		slti $t6, $s4, 121
		bne $t6, $zero, a2v
