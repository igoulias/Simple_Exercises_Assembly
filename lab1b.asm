# Lab1b 
# username: aem: 
# username: aem: 

.data
Str_ReadN1: .asciiz "Please give N1: "
Str_ReadN2: .asciiz "Please give N2: "
Str_msg1: .asciiz "\nThe max final union of ranges is ["
Str_Comma: .asciiz ","
Str_ClsBrack: .asciiz "]."
.text
.globl main


main:
	li $v0, 4		# Minima gia na isagoun ton N1
	la $a0, Str_ReadN1
	syscall
	
	li $v0, 5		# Diavazoume ton N1... 
	syscall		
	blez $v0, exit	#elegxos an diavasame thetiko arithmo
	move $s0, $v0		#...kai vazoume ston kataxoriti $s0, thetoume Min = N1
	
	
	li $v0, 4		# Minima gia na isagoun ton N2
	la $a0, Str_ReadN2
	syscall
		
	li $v0, 5		# Diavazoume ton N2...
	syscall	
	blez $v0, exit	#elegxoun an diavasame thetiko arithmo
	move $s1, $v0		#...kai vazoume ston kataxoriti $s1, thetoume Max = N2
	
	#vazoume to megalitero sto N1 kai to mikrotero sto N2 ...
	bleu $s0, $s1, loop	# An den xriazonte alagi tha ksekinisi i epanaliptiki diadikasi 
	move $s2, $s0
	move $s0, $s1
	move $s1, $s2
	
loop:	#while(1){	---------------Arxi tou loop---------------
	li $v0, 4		# Minima gia na isagoun ton N1'
	la $a0, Str_ReadN1
	syscall
	
	li $v0, 5		# Diavazoume ton N1'... 
	syscall		
	bltz $v0, loopEnd  #elegxos an diavasame thetiko arithmo,	if($v0<0) break;
	move $t0, $v0		#...kai vazoume ston kataxoriti $t0
	
	
	li $v0, 4		# Minima gia na isagoun ton N2'
	la $a0, Str_ReadN2
	syscall
		
	li $v0, 5		# Diavazoume ton N2'...
	syscall	
	bltz $v0, loopEnd  #elegxoun an diavasame thetiko arithmo,	if($v0<0) break;
	move $t1, $v0		#...kai vazoume ston kataxoriti $t1
	
	#vazoume to megalitero sto N1' kai to mikrotero sto N2' ... 
	bleu $t0, $t1, dontSwitch # apla prospername tis entoles pou tha antalasan tis times
	move $t2, $t0		
	move $t0, $t1
	move $t1, $t2		# o $t2 xrisimopiite os temp gia na kanoume tin antalagi
dontSwitch:
	
	bgtu $t0, $s0, NewGTOld	# an to N1'(kenourio) ine megalitero tou N1(palio) tote tha prosperasi tis entoles kai tha pai sto NewGTOld
	# --periptosi pou to N1(palio) ine megalitero tou N1'(kenourio)--
	bgtu $s0, $t1, case5_6	# stin peiptosi pou ine ksera metaksi tous (N1>N2') && (N1>N1') tha prospernai tis entoles kai tha pai sto case5_6...
	
	move $s0, $t0		# stis periptosis 1 kai 3 tha alaksoume sigoura to aristero akro... 
	bgeu $s1, $t1, loop	# stin perptosi pou to N2(palio) ine megalitero (h iso) tou N2'(kenourio) exoume tin periptosi 1... , if($s1 >= $t1) continue;
				# stin periptosi 1 den alazi to deksio akro...
	# --periptosi pou to [N1,N2] ine iposinolo tou [N1', N2'] (periptosi 3)--
	move $s1, $t1		# ananeonoume to deksio akro tou diastimatos....
	j loop		# continue;
	
NewGTOld:# --periptosi pou to N1'(kenourio) ine megalitero tou N1(palio)--
	bgtu $t0, $s1, case5_6	# stin peiptosi pou ine ksera metaksi tous (N1'>N1) && (N1>N2) tha prospernai tis entoles kai tha pai sto case5_6...
	
	bgtu $s1, $t1, loop	# stin perptosi pou to N2(palio) ine megalitero (h iso) tou N2'(kenourio) exoume tin periptosi 4... , if($s1 >= $t1) continue;
				# stin periptosi 4 den ginonte alages sta akra...
	# --periptosi pou prepi na epektinoume pros ta deksia (periptosi 2)
	move $s1, $t1		# ananeonoume to deksio akro tou diastimatos....
	j loop		# continue;
	
case5_6:# --periptosi pou ine ksena (periptosis 5 kai 6)--
	subu $t2, $s1, $s0	# ston $t2 exoume ton platos tou diastimatos [N1, N2],  $t2 >= 0
	subu $t3, $t1, $t0	# ston $t3 exoume ton platos tou diastimatos [N1', N2'], $t3 >= 0
	bgeu $t2, $t3, loop	# an to [N1,N2] ine megalitero(h iso) tote den tha alaksi to diastima... , if($t2 >= $t3) continue;
	move $s0, $t0
	move $s1, $t1		# ananeonoume ta akra tou diastimatos....
	j loop		# Pame gia tin epomeni epanalipsi, den xriazete na kanoume branch if giati kanoume ton elegxo me to pou diavasoume tis times...
loopEnd:#}	---------------Telos tou loop---------------
	
	# Ektiponoume to apotelesma
	li $v0, 4
	la $a0, Str_msg1
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, Str_Comma
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, Str_ClsBrack
	syscall
	
exit:	#exit program
	li $v0, 10
	syscall
