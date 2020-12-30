#############################################################################
# Author: Maximilian Patterson
# Description: Calculates if a user input integer is a triangle number or not
#############################################################################

.data
	prompt: .asciiz	"Enter a positive integer. N = "
	error: .asciiz	"Sorry, you must enter a positive integer.\n"
	is_tri: .asciiz " is a triangle number with k = "
	new_line: .asciiz "\n"
	not_tri: .asciiz " is not a triangle number ("
	not_tri_end: .asciiz ")\n"
	less_than: .asciiz " < "

.text
input:
	li $v0, 4		# Outputs prompt for input
	la $a0, prompt
	syscall
	
	li $v0, 5		# Stores user input int at $v0
	syscall
	
	addi $t7, $v0, 0	# Move input (N) to $t7

	ble $t7, $zero, input_error	# if input $t7 <= 0 (less than 1) go to input_error

	li $t6, 1		# Sets K to 1 at $t6
	li $t5, 1		# Sets SUM to 1 at $t5
	
compare_and_add:
	bge $t5, $t7, sum_bge_input
	
	addi $t6, $t6, 1	# Adds 1 to K
	
	add $t5, $t5, $t6	# Adds SUM + K
	
	j compare_and_add
	
sum_bge_input:
	li $v0, 1		# Outputs N at $t7
	move $a0, $t7
	syscall
	
	beq $t5, $t7, sum_beq_input # if sum == N jump sum_beq_input
	j sum_not_beq_input		# else jump to sum_not_beq_input
	
sum_beq_input:
	li $v0, 4		# Outputs is_tri
	la $a0, is_tri
	syscall
	
	li $v0, 1		# Outputs K at $t6
	move $a0, $t6
	syscall
	
	li $v0, 4		# Outputs new_line
	la $a0, new_line
	syscall
	j end

sum_not_beq_input:
	li $v0, 4		# Outputs not_tri
	la $a0, not_tri
	syscall
	
	sub $t6, $t5, $t6	# SUM - K
	
	li $v0, 1		# Outputs K at $t6
	move $a0, $t6
	syscall				
	
	li $v0, 4		# Outputs less_than
	la $a0, less_than
	syscall

	li $v0, 1		# Outputs N at $t7
	move $a0, $t7
	syscall	
	
	li $v0, 4		# Outputs less_than
	la $a0, less_than
	syscall

	li $v0, 1		# Outputs SUM at $t5
	move $a0, $t5
	syscall
	
	li $v0, 4		# Outputs not_tri_end
	la $a0, not_tri_end
	syscall
	
	j end
	
end:
	li $v0, 10		# Cleanly closes program
	syscall
	
input_error:
	li $v0, 4		# Outputs error
	la $a0, error
	syscall
	
	j input
