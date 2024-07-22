#Vince Bengco
#CPE 404
#Project 1
#10 x 10 Matrix Multiplier
Init:
addi $8, $0, 10  			# Dedicatged Max row Size
addi $2, $0, 10				# Dedicated Max Column Size
addi $17, $0, 40			#Used to go to the next row/column in the array for the matrix
addi $22, $0, 90			#Used for the iterations in the matrix

addi $23, $0, 11			#check for out of bounds in incrementing 

addi $12, $0, 1				# Dedicated register with value 1
addi $6, $0, 4				#address + 4

addi $9, $0, 0				# row counter
addi $11, $0, 0				# used for SLT




addi $5, $0, 0				#temporary register 
addi $14, $0, 0				#temporary register for Matrix B
addi $15, $0, 0				#temporary register for Matrix B

addi $7, $0, 0				#track address
addi $16, $0, 0				#counter for multiplication 
addi $18, $0, 1				#Counts the number of multiplied values	
	


################	MATRIX A	##########
INITIALA:
and $3, $0, $0
and $4, $0, $0				#initialize rows and columns to zero

MatrixA:
addi $5,$5, 1				#Increments the value in the matrix
beq $5, $23 IndexValA

RetMatA:
sw $5, 0x10010000($7) 			#The Matrix/Array, hex value is the start of data segment in MARS 4.5
add $7, $7, $6				#Increments the Address by 4
addi $3, $3, 1				#Increments the index/element			
beq $3, $8 ColumnCheckA			#checks if the value is 10 and branchs if equal		
j MatrixA

ColumnCheckA:
addi $9, $9, 1				#Used for the beginning of the array
and $3, $3, $0				#reinitialize rows to 0


and $5, $5, $0				#Resets the actual value of matrix to 0
add $5, $5, $9				#starts the row of the matrix of $9				
addi $4, $4, 1
beq $2, $4, INITIALB

j MatrixA

IndexValA:
and $5, $5, $0				#Reset $5 to zero
addi $5, $5, 1								
j RetMatA



################	MATRIX B	##########
INITIALB:
add $3,$0,$0				#initialize rows to zero
add $4,$0,$0				#initialize columns to zero
and $5,$5,$0				#initialize temporary register
and $9,$9,$0				
add $9,$0, $8				#initialize value with 10
sub $9, $9, $12				#Subtract 1 making $9 = 9 initially
addi $5,$5,9				#initial value of first element in the matrix		
		

MatrixB:
add $5,$5, 1				#Increments the value in the matrix
beq $5, $23 IndexValB

RetMatB:
sw $5, 0x10010000($7) 			#The Matrix/Array, hex value is the start of data segment in MARS 4.5
add $7, $7, $6				#Increments the Address by 4
addi $3, $3, 1				#Increments the index/element			
beq $3, $8 ColumnCheckB			#checks if the value is 10 and branchs if equal		
j MatrixB

ColumnCheckB:
addi $4, $4, 1

and $3, $3, $0				#reinitialize rows to 0
and $5, $5, $0				#Resets the actual value of matrix to 0
sub $9, $9, $12				#Subtract 1
add $5, $5, $9				#starts the row of the matrix with the value of $9				
beq $2, $4, SUMLOOPINITIAL
and $3, $3, $0				#reinitialize rows to 0
j MatrixB

IndexValB:
and $5, $5, $0				#Reset $5 to zero
addi $5, $5, 1										
j RetMatB
	
				
################	SUM LOOP	##########						
SUMLOOPINITIAL:		
and $9,$9,$0		
and $5, $0, $0				#Reset Temp register
and $3, $0, $0				#Used to initialize number of iterations, should only go up to 10 times
#addi $3, $3, 1						
addi $10, $0, 800			#Address of multiplied matrix

and $4, $0, $0				#reset columns

and $7, $0, $0				#Reset address tracker to zero


addi $13, $0, 400			#Used to track Address of Matrix B
addi $20, $0, 0			#Track which row the multiplier is using
addi $21, $0, 0			#Track which column the multiplier is using 
nop

LOAD:
lw $15, 0x10010000($7)			#load value in $15 
nop
nop
lw $14, 0x10010000($13)			#load value in $14
nop
nop
slt $11, $15, $14			#if the value in Matrix A is less than Matrix B set $11 to 1
nop
BEQ $11, $0, SUMLOOP2			#branch to SUMLOOP2

SUMLOOP1:	
add $5, $5, $14				#Adds to $5 for sum loop
sub $15, $15, $12			#Subtract the lesser value by 1
nop
beq $15, $0, CHECKMULTCOUNT
j SUMLOOP1


SUMLOOP2: 	
add $5, $5, $15				#Adds to $5 for sum loop
and $9, $9, $0				#hazard avoidance

sub $14, $14, $12			#Subtract the lesser value by 1

beq $14, $0, CHECKMULTCOUNT
j SUMLOOP2


CHECKMULTCOUNT:
addi $16, $16, 1			#increment counter by one
BEQ $16, $2, RELOAD
nop
add $7, $7, $6				#next address + 4 in data
add $13, $13, $17			#add 40 to get the next 10th value in the array for the matrix
j LOAD
																												 																																																												 																																																										 																																																												 																														
RELOAD:
sw $5, 0x10010000($10)			#store into the multiplied matrix dataspace
add $10, $10, $6			#increment the address by 4

and $5, $5, $0				#Reset Temp register
and $7, $7, $0
add $7, $7, $20				#Choose the Row the Matrix is on

and $13, $13, $0
addi $13, $13, 400			#Reset Column
add $21, $21, $6			#Increment column tracker
add $13, $13, $21			#Next Column in the Array



addi $18, $18, 1			#increments the counter for how many has been multiplied
#slt $11, $18, $19
and $9, $9, $0				#hazard avoidance
slt $11, $2, $18			#Checks how many times we have multiplied and sets it to one if we are at max length			
and $16, $16, $0			#Reset counter
beq $11, $0, LOAD	

FINALCHECK:
addi $18, $0, 1				#RESET multiply check	

and $7, $7, $0				#reset row address
add $20, $20, $17			#adds 40 to the base address
add $7, $7, $20				#increment row

and $13, $13, $0
addi $13, $13, 400			#Reset Column


addi $3, $3, 1				#increment iteration
slt $11, $2, $3
and $21, $21, $0			#reset to first column
beq $11, $0, LOAD		



