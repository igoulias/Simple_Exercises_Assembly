# Lab1a count leading zeros
# username: aem: 
# username: aem: 


.data
Str_msg1: .asciiz "Number "
Str_msg2: .asciiz " has "
Str_msg3: .asciiz " leading zeros"
#Str_Space: .asciiz " "

.text
.globl main

# Perigrafi:
# olisthenoume ton arithmo pros ta deksia mexri na isoute me to 0
# ara mporoume na doume posa bits exoume prin apo ta leading zeros 
# kathe fora pou kanoume olithisi aferoume kai 1 apo ton counter pou 
# exoume arxikopiisi se 32

#
main:
	li $v0, 5		# Etimazontas tin anagnosi akereou apo tin konsola
	syscall		
	move $s0, $v0		# Apothikevoume ton arithmo pou mas edosan ston $s0
	li $t1, 32		# Esto pos to $t1 ine o counter ton leading zeros
	beqz $s0,skip_loop# na prosperasi to loop an mas dothike 0 apo tin konsola
	
	move $t0, $s0		# Epidi theloume na ektiposoume kai ton arithmo pou mas edosan xriasimopioume alon kataxoriti gia tis praksis
loop:	#do {
	addi $t1, $t1, -1	# aferoume 1 apo ton counter kathos o $t0 den isoute me to 0... 
	srl $t0, $t0, 1		# Kanoume deksia olisthisi...
	bnez $t0, loop	#}while($t0 != 0)
skip_loop:
	# Ektiponoume to apotelesma stin kosnola, me katalilo minima
	li $v0, 4		
	la $a0 Str_msg1
	syscall			
	
	li $v0, 1
	move $a0, $s0
	syscall		
	
	li $v0, 4		
	la $a0 Str_msg2
	syscall			
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4		
	la $a0 Str_msg3
	syscall			
	
#exit program
	li $v0, 10
	syscall
