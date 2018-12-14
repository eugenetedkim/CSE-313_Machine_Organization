;*******************************************************

; MONTH		x31F1: 1
; DATE		x31F2: 1
; YEAR		x31F3: 1900
; CENTURY	x31F4: 
; DECADE	x31F5: 

; R0: MONTH		R4: C
; R1: DATE		R5: D
; R2: YEAR		R6: f
; R3: m			R7: 

;*******************************************************

	.ORIG	x3000



;*******************************************************

; Load data values into registers 0, 1, and 2
	LDI	R0, MONTH
	LDI	R1, DATE
	LDI	R2, YEAR

;*******************************************************

; R0: 1 (MONTH)		R4: C
; R1: 1	(DATE)		R5: D
; R2: 1900 (YEAR)	R6: f
; R3: 			R7: 

;*******************************************************

; Calculating 'm'

	; Bring R0 into scope
	ADD	R0, R0, #0

	; -2 from MONTH to test if Jan or Feb
	ADD	R3, R0, #-2


;*******************************************************

; R0: 1 (MONTH)		R4: C
; R1: 1	(DATE)		R5: D
; R2: 1900 (YEAR)	R6: f
; R3: -1		R7: 

;*******************************************************

	; If R3 is neg or zero (Jan or Feb), +10 to MONTH
	BRnz	BRANCH1

	BR	BRANCH2
BRANCH1	LDI	R0, MONTH

	ADD	R0, R0, #10


;*******************************************************

; R0: 11	R4: C
; R1: 1		R5: D
; R2: 1900	R6: f
; R3: m		R7: 

;*******************************************************

; Calculating 'C' and 'D'

	; BRING MONTH into scope
BRANCH2	LDI	R0, MONTH


	; -2 from MONTH to test if Jan or Feb
	ADD	R0, R0, #-2


	; If neg or zero (Jan or Feb), -1 to YEAR, 
	BRnz	BRANCH3
	JSR	DIV

	STI	R4, QUOTIENT

	STI	R5, MODULUS

	BR	BRANCH4

BRANCH3	ADD	R2, R2, #-1

	JSR	DIV
	STI	R5, MODULUS

	ADD	R2, R2, #1

	AND	R4, R4, #0

	JSR 	DIV

	STI	R4, QUOTIENT








	LEA	R0, DAYS
	ADD	R4, R4, #0
LOOP	BRz	DISPLAY
	ADD	R0, R0, #10
	ADD	R3, R3, #-1
	BR	LOOP
DISPLAY	PUTS
BRANCH4	HALT

;*******************************************************

MONTH	.FILL	x31F0

DATE	.FILL	x31F1

YEAR	.FILL	x31F2

DAY	.FILL	x31F3

QUOTIENT.FILL	x31F4

MODULUS	.FILL	x31F5



;*******************************************************

; Division Subroutine

	
DIV	ADD	R5, R2, #0

	ADD	R5, R5, #-10
	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10
	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

LOOP2	ADD	R5, R5, #0

	BRzp	BRANCH5

	ADD	R5, R5, #10

	ADD	R5, R5, #10

	ADD	R5, R5, #10

	ADD	R5, R5, #10

	ADD	R5, R5, #10

	ADD	R5, R5, #10

	ADD	R5, R5, #10

	ADD	R5, R5, #10
	ADD	R5, R5, #10

	ADD	R5, R5, #10

	RET

BRANCH5	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R5, R5, #-10

	ADD	R4, R4, #1

	BR	LOOP2

;

;*******************************************************

DAYS	.STRINGZ	"Sunday   "

	.STRINGZ	"Monday   "

	.STRINGZ	"Tuesday  "

	.STRINGZ	"Wednesday"
	.STRINGZ	"Thursday "

	.STRINGZ	"Friday   "

	.STRINGZ	"Saturday "



;*******************************************************

	.END


;*******************************************************