;*******************************************************

	; MONTH		x31F0: 1
	; DATE		x31F1: 1
	; YEAR		x31F2: 1901

;*******************************************************

	.ORIG	x3000



;*******************************************************

; Load data values into registers 0, 1, and 2
	LDI	R0, MONTH
	LDI	R1, DATE
	LDI	R2, YEAR

	; R0: 1
	; R1: 1
	; R2: 1901

;*******************************************************
; Calculating 'm'

	; -2 from R0 and load into R3
	ADD	R3, R0, #-2

	; USUAL MONTH/FREE SPACE	R0: 1
	; DATE (k)/FIXED		R1: 1
	; YEAR/FREE SPACE		R2: 1901
	; CONVERTED MONTH (m)/FIXED	R3: 11
	; CENTURY (C)/FIXED		R4: -1
	; DECADE (D)/FIXED		R5: 
	; FREE SPACE			R6: 
;*******************************************************
	; If R3 is neg (Jan) or zero (Feb), +10 to MONTH
	BRnz	BRANCH1

	STI	R3, DAY
	BR	BRANCH2
BRANCH1	AND	R3, R3, #0
	ADD	R3, R0, #10

	STI	R3, DAY	
;*******************************************************
; Calculating 'C' and 'D'
	; -2 from R0 and load into R4
BRANCH2	ADD	R4, R0, #-2

	; USUAL MONTH/FREE SPACE	R0: 1
	; DATE (k)/FIXED		R1: 1
	; YEAR/FREE SPACE		R2: 1901
	; CONVERTED MONTH (m)/FIXED	R3: 11
	; CENTURY (C)/FIXED		R4: -1
	; DECADE (D)/FIXED		R5: 
	; FREE SPACE			R6: 

	; If neg (Jan) or zero (Feb), branch
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
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-10
	ADD	R6, R6, #-9
	ADD	R6, R5, R6
	BRz	BRANCH5
	BR	BRANCH6
BRANCH5	ADD	R4, R4, #1
BRANCH6	STI	R4, CENTURY
	STI	R5, DECADE

	; USUAL MONTH/FREE SPACE	R0: -100
	; DATE (k)/FIXED		R1: 1
	; YEAR/FREE SPACE		R2: 1
	; CONVERTED MONTH (m)/FIXED	R3: 11
	; CENTURY (C)/FIXED		R4: 0
	; DECADE (D)/FIXED		R5: 1900
	; FREE SPACE			R6: 1900

;*******************************************************
	
	; MONTH		x31F0: 1
	; DATE		x31F1: 1
	; YEAR		x31F2: 1900
	; DAY		x31F3: 11
	; CENTURY	x31F4: 0
	; DECADE	x31F5: 99
	; TEST		x31F6: 143 (13*'m')

	; R0: 0			R4: 19 ('C' or CENTURY)
	; R1: 1	('k' or DATE)	R5: 99 ('D' or DECADE)
	; R2: 0 (YEAR)		R6: 11 ('f')
	; R3: 11 ('m')		R7:

; f = R1 + [(R0 * R3) - 1]/5 + R5 + R5/4 + R4/4 - (2 * R4)

; R0: 13 (CONSTANT 13 or CONSTANT 2)
; R2: 11 ('m' or 'C')
; R6: 142 
; Use below after R1 and R5 have been applied to the above formula
; Clear R1 and R5 before using
; R1
; R5:
;*******************************************************
; Calculating 'f'

	;LDI	R5, DECADE
	;AND	R0, R0, #0
	;AND	R2, R2, #0
	;AND	R6, R6, #0
	;ADD	R0, R0, #13
	;ADD	R2, R3, #0
	;JSR	MULT
	;ADD	R6, R6, #-1

	;JSR	DIV


;*******************************************************

BRANCH4	HALT

;*******************************************************

MONTH		.FILL	x31F0

DATE		.FILL	x31F1

YEAR		.FILL	x31F2

DAY		.FILL	x31F3

CENTURY		.FILL	x31F4

DECADE		.FILL	x31F5


TEST		.FILL	x31F6

;*******************************************************

; Division Subroutine
	
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


;*******************************************************

; MULTIPLICATION Subroutine

MULT	ADD	R6, R6, R0
	ADD	R2, R2, #-1
LOOP1	BRz	BRANCH8
	ADD	R6, R6, R0
	ADD	R2, R2, #-1
	BR	LOOP1
BRANCH8	RET

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