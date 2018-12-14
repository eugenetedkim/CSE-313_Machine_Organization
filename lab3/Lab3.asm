; Class:	CSE 313 Machine Organization Lab
; Section:	02
; Instructor:	Professor Taline Georgiou
; Term:		Fall 2018
; Name:		Eugene Kim
; Lab #3:	Days of the Week
; Description:		This program outputs which day of the week
;		your input corresponds to. The input must be in the
;		range 0-6, anything else will terminate the program.
;		The program will execute again until an invalid input.
;
;			It does this by first checking if the user input
;		falls into the 0-6 range using branch and arithmetic
;		operations. The program halts if the input does not meet
;		this condition. It further uses the input to load and print
;		the corresponding string value. 
;		
;			Engineering this program to terminate when the input
;		was out of range was challenging. After many attempts, I finally
;		figured out how to make comparisons by utitizing subtraction and
;		the branch operations.

	.ORIG	x3000

; Print Title of the Program
	LEA	R0, HEADING1	; Load effective address referenced by HEADING1 into register R0
	PUTS			; Output null terminating string to the console starting at address contained in R0
	LD	R0, NEWLINE	; Load the ASCII value found at the address referenced by the NEWLINE label
	OUT			; Output character in R0 to the console
	LEA	R0, HEADING2
	PUTS
	LD	R0, NEWLINE
	OUT

; Print prompt asking user to input an integer between 0 and 6
	LEA	R0, PROMPT
	PUTS
	LD	R0, NEWLINE
	OUT

RESTART	IN			; Output a prompt requesting the user to input
				; a character, and read-in the input
	ADD	R3, R0, #0	; Load input and offset it by -48 (basically converting the character input into decimal)
	ADD	R3, R3, #-16
	ADD	R3, R3, #-16
	ADD	R3, R3, #-16
	BRzp	ZP		; Branch if result is zero or positive which means the input passes phase 1
	HALT			; Halt the processor if not
ZP	AND	R7, R7, #0	; Clear R7 which is the first step in the phase 2 process for testing the input
	ADD	R7, R7, #6	; Load R7 with integer 6
	NOT	R7, R7		; 2's compliment of 6
	ADD	R7, R7, #1	
	ADD	R6, R3, R7	; Subtracting input by 6 because to test the appropriate range
	BRnz	CONT		; Branch if result is zero or negative (test to see if result is positive which means not in the range between 0 and 6)
	HALT			; Halt the processor if out of range
CONT	LEA	R0, DAYS	; Load memory address into R0 where the DAYS
				; strings are located
	ADD	R3, R3, #0	; Bring input into scope for further evaluation
LOOP	BRz	DISPLAY		; Branch if input is a zero
	ADD	R0, R0, #10	; If not, move memory address of the next string
	ADD	R3, R3, #-1	; into R0 and decrement the input by 1
	BR	LOOP		; Branch to LOOP
DISPLAY	PUTS			; Output string contained at the memory address until null terminating character
				; in R0
	LD	R0, NEWLINE
	OUT
	BR	RESTART
HEADING1	.STRINGZ	"		LAB 3"
HEADING2	.STRINGZ	"	DAYS OF THE WEEK"
PROMPT		.STRINGZ	"*Input integer 0-6 to output corresponding day"
DAYS		.STRINGZ	"Sunday   "
		.STRINGZ	"Monday   "
		.STRINGZ	"Tuesday  "
		.STRINGZ	"Wednesday"
		.STRINGZ	"Thursday "
		.STRINGZ	"Friday   "
		.STRINGZ	"Saturday "
NEWLINE		.FILL		x0A		; x0A is the hexadecimal value for the ASCII new line character
		.END


