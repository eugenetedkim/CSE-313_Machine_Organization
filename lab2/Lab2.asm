; Class:	CSE 313 Machine Organization Lab
; Section:	02
; Instructor:	Professor Taline Georgiou
; Term:		Fall 2018
; Name:		Eugene Kim
; Lab #2:	Arithmetic Functions
; Description:		This program implements
;		a subtraction function using ADD
;		and bitwise NOT operations,
;		and an absolute value function
;		using the branching operation.
;		With the combination of functions
;		and ALU operations, the program,
;		with inputs X and Y, computes 
;		the difference X - Y,
;		the absolute values of X and Y,
;		and if X or Y is larger
;		or if they are equal.
;
;			When running, the program
;		loads the data values X and Y into
;		the registers for use. They are
;		processed using arithmetic functions
;		which are built and composed of
;		ALU operations. After manipulation,
;		the data values are then stored back
;		into their corresponding memory locations.
;
;			Memory locations will contain
;		data values with results from the following:
;
;			x3122	X - Y
;			x3123	|X|
;			x3124	|Y|
;			x3125	Z =	{0 if |X|-|Y| = 0,
;				 	 1 if |X|-|Y| > 0,
;				 	 2 if |X|-|Y| < 0}
;
; Place code into memory
	.ORIG x3000

; Load X and Y into registers for use
	LDI	R0, X
	LDI	R1, Y

; X+(-Y)
	NOT	R2, R1
	ADD	R2, R2, #1
	ADD	R2, R0, R2
	STI	R2, X_Y

; absX
	ADD	R3, R0, #0
	BRzp	ZP1
	NOT	R3, R3
	ADD	R3, R3, #1
	STI	R3, absX
ZP1	STI	R3, absX
	
; absY
	ADD	R4, R1, #0
	BRzp	ZP2
	NOT	R4, R4
	ADD	R4, R4, #1
	STI	R4, absY
ZP2	STI	R4, absY

; |X|-|Y|
	AND	R6, R6, x1
	NOT	R5, R4
	ADD	R5, R5, #1
	ADD	R5, R3, R5

; Z
	BRz	ZERO
	BRp	POS
	BRn	NEG
NEG	ADD	R6, R6, #1
POS	ADD	R6, R6, #1
ZERO	ADD	R6, R6, #0
	STI	R6, Z

; Tell LC-3 simulator to stop running the program 
	HALT

; Referencing memory locations
X	.FILL x3120
Y	.FILL x3121
X_Y	.FILL x3122
absX	.FILL x3123
absY	.FILL x3124
Z	.FILL x3125
	.END




























