####################################
####################################
###Emilio Volpe
###John Scipion
###Jon McRae
###Chris Michel
###CSE 3666 FALL 15
###Homework 5: Random Memory Access
####################################
####################################


	Merge_Sort:
	move $t0, $a0						# Copy input array address to $t0
	move $t8, $a0						# Make secondary copy ->(not to be manipulated)<-
	lw $t1, ($t0)						# load the first value of the array (length) into $t1
	beq $t1, $0, CZero  				# If length == 0, end
	li $t3, 2							# Load 2 into $t3 for register division
	div $t1, $t3						# $t1 / 2
	mfhi $t2  							# Remainder from division by two
	mflo $t1							# $t1 = floor ($t1/2)
	move $t7, $t1						# second half array length = $t1/2
	add $t1, $t1, $t2					# $t1 = $t1 + R (0 or 1)
	move $t6, $t1						# first half array length = $t1/2 + R
	mul $t1, $t6, 4						# Calculate total memory of subarray1
	add $t1, $t0, $t1					# Calculate beginning address of right array
	add $t3, $t6, $t7 					# Calculate the total length of the array
	move $t9, $t3						# Save the total length in value $t9, do not touch
	addi $sp, $sp, -4					# Move the stack pointer over

	
	mergesort:
	
		lw $t4, ($t0)					# Load first element from array 1
		lw $t5, ($t1)					# Load first element from array 2
		bgt $t4, $t5, SubArray2			# Compare the two elements  if array 1 element < array 2 element go to SubArray1
		
		SubArray1:
		beq $t6, $zero, SubArray2		# Make sure array1 has an unsaved element
		sw $t5, 0($sp)					# Save the array1 element onto the stack.
		addi $t0, $t0, 4				# Move the pointer
		sub $t6, $t6, 1					# Subtract number of array1 unsaved elements by one
		j CombineArrays					# Jump to CombineArrays
		
		SubArray2:
		beq $t7, $0, SubArray1			# Make sure array2 has an unsaved element
		sw $t4, 0($sp)					# Save the array2 element onto the stack
		addi $t1, $t1, 4				# Move the right pointer to next element
		sub $t7, $t7, 1					# Subtract number of array2 unsaved elements by one
		
		CombineArrays:
		addi $sp, $sp, -4       		# move the stack pointer to next element
		add $t3, $t6, $t7				# Calculate the total number of unsaved elements in whole array
		beq $t3, $0, Finish				# If #t3 = 0, go to Finish
		j mergesort						# Otherwise mergesort
		
	Merge:
	lw $t8, 0($sp)						# load element from sorted array
	addi $t3, $t3, -1					# Length = Length - 1 per iteration of the loop
	addi $sp, $sp, -4					# Allocate space on the stack 
	addi $t8, $t8, 4					# Increment memory address on Array
	bgt $t3, $0, Merge					# If length > 0 Merge again
	move $v0, $t8						# Once loop is finished, copy sorted array to $v0
	add $sp, $sp, $t9					# Move stack pointer to end of the array
	addi $sp, $sp, 4					# Move sp to initial address
	jr $ra								# Jump to Return Address
		
	Finish: 
	move $t3, $t9						# Copy the total length of the array to $t3	
	mul $t9, $t9, 4						# Calculate the amount of memory needed
	add $sp, $sp, $t9					# Move the stack pointer to end of the array
	move $v0, $t8						# Copy the given input back to the output $v0
	jr $ra								# Jump to Return Address
		
		
	CZero:
	move $v0, $a0						# Copy the given array to $v0 when 0 is the input
	jr $ra								# Jump to Return Address


