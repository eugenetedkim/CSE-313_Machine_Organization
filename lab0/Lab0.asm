;General Information: All programs should follow this header
; template, adjusted accordingly:

;Class:CSE 313 Machine Organization Lab
;Section: 02
;Instructor: Taline Georgiou
;Term: Fall 2018
;Name: Eugene Kim
;Lab#0: Programming in LC-3
;Description: (No less than two paragraphs. Describe what the
;program does, its legal inputs, outputs, side effects; how
;to run it, etc.)
;The description should be detailed enough so that someone
;by reading it should be able to tell what the program
;does and how to use it. If a program does not adhere to
;this header, up to 15% of its grade will be deducted.
;Students may work in groups of two.
;Lab assignments are specified within the Lab Manual.

; LC-3 Program that displays
; "Hello World!" to the console
	.ORIG	x3000
	LEA	R0, HW	; load address of string
	PUTS		; output string to console
	HALT		; end program
HW	.STRINGZ "Hello World!"
	.END