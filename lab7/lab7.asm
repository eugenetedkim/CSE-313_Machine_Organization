
	.ORIG	x3000


	LDI	R0, MONTH
	LDI	R1, DATE
	LDI	R2, YEAR

; Calculating 'm'

	ADD	R3, R0, #-2
	BRnz	BRANCH1

	STI	R3, DAY
	BR	BRANCH2
BRANCH1	AND	R3, R3, #0
	ADD	R3, R0, #10


; Calculating 'C' and 'D'

BRANCH2	ADD	R4, R0, #-2

	BRnz	BRANCH3
	AND	R4, R4, #0
	AND	R0, R0, #0
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R6, R2, #0
	JSR	DIV
	ADD	R5, R6, #0
	AND	R6, R6, #0
	STI	R4, CENTURY
	STI	R5, DECADE
	BR	BRANCH4

BRANCH3	AND	R4, R4, #0
	ADD	R5, R2, #-1

	AND	R2, R2, #0
	ADD	R2, R0, #0
	AND	R0, R0, #0
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R0, R0, #-10
	ADD	R6, R5, #0
	AND	R5, R5, #0
	JSR	DIV
	ADD	R5, R6, #0
	AND	R6, R6, #0
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-10
;	ADD	R6, R6, #-9
;	ADD	R6, R5, R6
;	BRz	BRANCH5
;	BR	BRANCH6
;BRANCH5	ADD	R4, R4, #1

; Calculating 'f'
BRANCH6	AND	R0, R0, #0
	AND	R2, R2, #0
	AND	R6, R6, #0
	ADD	R0, R0, #13
	ADD	R2, R3, #0
	JSR	MULT
	AND	R0, R0, #0
	AND	R2, R2, #0
	ADD	R2, R4, #0
	AND	R4, R4, #0
	AND	R3, R3, #0
	ADD	R3, R6, #-1
	AND	R6, R6, #0
	ADD	R0, R0, #-5
	ADD	R6, R3, #0
	AND	R3, R3, #0
	JSR	DIV
	AND	R0, R0, #0
	AND	R3, R3, #0
	ADD	R3, R4, #0
	AND	R4, R4, #0
	AND	R6, R6, #0
	ADD	R6, R5, #0
	ADD	R0, R0, #-4
	JSR	DIV
	ADD	R1, R1, R3
	AND	R3, R3, #0
	ADD	R1, R1, R4
	AND	R4, R4, #0
	AND	R6, R6, #0
	ADD	R6, R2, #0
	AND	R0, R0, #0
	ADD	R0, R0, #-4
	JSR	DIV
	ADD	R1, R1, R4
	ADD	R1, R1, R5
	ADD	R2, R2, R2
	NOT	R2, R2
	ADD	R2, R2, #1
	ADD	R1, R1, R2
	STI	R1, TESTT

	
	
	
;R0: -4
;R1: 1	k
;R2: 19 C 
;R3: 28 {[(13 * m) - 1] / 5}
;R4: 24 (D / 4)
;R5: 99	D
;R6: 99

; f = k + {[(13 * m) - 1] / 5} + D + (D / 4) + (C / 4) - (2 * C)
;   = R1 + {[(13 * R3) - 1] / 5} + R5 + (R5 / 4) + (R2 / 4) - (2 * R2)
	
	


	
	

BRANCH4	HALT

MONTH		.FILL	x31F0

DATE		.FILL	x31F1

YEAR		.FILL	x31F2

DAY		.FILL	x31F3

CENTURY		.FILL	x31F4

DECADE		.FILL	x31F5


TEST		.FILL	x31F6
TESTT		.FILL	x31F7


; Division Subroutine
	; R6: NUMERATOR
	; R0: DENOMINATOR
	; R4: COUNT
	
DIV	ADD	R6, R6, R0
LOOP2	ADD	R6, R6, #0
	BRzp	BRANCH7
	NOT	R0, R0
	ADD	R0, R0, #1
	ADD	R6, R6, R0
	RET

BRANCH7	ADD	R6, R6, R0
	ADD	R4, R4, #1

	BR	LOOP2

;

; MULTIPLICATION Subroutine

MULT	ADD	R6, R6, R0
	ADD	R2, R2, #-1
LOOP1	BRz	BRANCH8
	ADD	R6, R6, R0
	ADD	R2, R2, #-1
	BR	LOOP1
BRANCH8	RET

DAYS	.STRINGZ	"Sunday   "

	.STRINGZ	"Monday   "

	.STRINGZ	"Tuesday  "

	.STRINGZ	"Wednesday"
	.STRINGZ	"Thursday "

	.STRINGZ	"Friday   "

	.STRINGZ	"Saturday "



	.END
