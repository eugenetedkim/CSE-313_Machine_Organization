;Class: CSE 313 Machine Organization Lab
;Section: 02
;Instructor: Professor Taline Georgiou
;Term: Fall 2018
;Name: Eugene Kim
;Lab#1: ALU Operations
;Description:
;	The program loads input integers X and Y 
;into the general purpose registers and executes a 
;series of ALU arithmetic and bitwise operations 
;where the results are saved in their 
;corresponding memory locations. Legal inputs are 
;integers with no displayed output in the LC3 
;Console and side effects to error are floating 
;point numbers as inputs.
;	To use this program, enter different 
;values for X and Y and notice the computations 
;being carried out through each specified LC-3 
;instruction. Verify the arithmetic and bitwise 
;operations being performed by checking the 
;content

; Values X and Y are loaded into registers R1 and R3.
	.ORIG	x3000	; Address where program code begins
; R2 is loaded with the beginning address of the data using xFF (find out more about this).
	LEA	R2, xFF		; R2 <- x3000 + x1 + xFF (= x3100)
; X, which is located at x3100, is loaded into R1 using LDR instruction.
	LDR	R1, R2, x0	; R1 <- MEM[x3100 + x0]
; Y, which is located at x3101, is loaded into R3 using LDR instruction.
	LDR	R3, R2, x1	; R3 <- MEM[x3100 + x1]
; Adding two registers R1 and R3 (X + Y) and storing the sum value in register R4 using AND instruction.
	ADD	R4, R1, R3	; R4 <- R1 + R3
; Storing register R4 (X + Y) in memory location x3102 (x3100 + x2) using STR instruction.
	STR	R4, R2, x2	; x3102 <- R4
; ANDing registers R1 and R3, bitwise using the AND instruction, and storing the value in register R4.
	AND	R4, R1, R3	; R4 <- R1 AND R3
; Storing register R4 (X AND Y)to memory location x3100 + x3.
	STR	R4, R2, x3	; x3103 <- R4
; Inverting (flipping) the bits of register R1 and storing it in register R5.
	NOT	R5, R1		; R5 <- NOT(R1)
; Inverting (flipping) the bits of register R3 and storing it in register R6.
	NOT	R6, R3		; R6 <- NOT(R3)
; ANDing registers R5 and R6, bitwise using the AND instruction, and storing the value in register R4.
	AND	R4, R5, R6	; R4 <- R5 AND R6
; Inverting (flipping) the bits of register R4 and storing it in register R4.
	NOT	R4, R4		; R4 <- NOT(R4)
; Storing register R4 in memory location x3100 + x4.
	STR	R4, R2, x4	; x3104 <- R4
; Inverting (flipping) the bits of register R1 and storing it in register R4. 
	NOT	R4, R1		; R4 <- NOT(R1)
; Storing register R4 to memory location x3100 + x5.
	STR	R4, R2, x5	; x3105 <- R4
; Inverting (flipping) the bits of register R3 and storing it in register R4.
	NOT	R4, R3		; R4 <- NOT(R3)
; Store register R4 into memory location x3100 + x6.
	STR	R4, R2, x6	; x3106 <- R4
; ADDing register R1 and a constant 3 and storing the sum value into reigster R4.
	ADD	R4, R1, x3	; R4 <- X + 3
; Store register R4 to memory location x3100 + x7.
	STR	R4, R2, x7	; x3107 <- R4
; ADDing register R3 and a constant -3 and storing the sum value into register R4.
	ADD	R4, R3, x-3	; R4 <- Y - (-3)
; Storing register R4 in memory location x3100 + x8.
	STR	R4, R2, x8	; x3108 <- R4
; ANDing register X in hexadecimal and 0000 0000 0000 0001, bitwise and storing the value in register R4. 
	AND	R4, R1, x1	; R4 <- R1 AND x1
; Storing register R4 in memory location x3100 + x9.
	STR	R4, R2, x9	; x3109 <- R4
	HALT
	.END