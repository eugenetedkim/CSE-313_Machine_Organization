		.ORIG	x3000

		LDI	R0, X
		LDI	R1, Y

		JSR	MULT
		STI	R2, PRODUCT

		LDI	R0, X
		LDI	R1, Y

		JSR	DIV
		ADD	R2, R2, x0
		BRp	SWERVE1
		STI	R2, QUOTIENT
		STI	R2, MODULUS
		BR	SWERVE2
SWERVE1		STI	R3, QUOTIENT
		STI	R4, MODULUS
SWERVE2		HALT

X		.FILL	x3100
Y		.FILL	x3101
PRODUCT		.FILL	x3102
QUOTIENT	.FILL	x3103
MODULUS		.FILL	x3104

; MULTIPLICATION SUBROUTINE
MULT		ADD	R4, R4, x1	; Initialize R4 (sign) with 1 which indicates that the operands are both positive.
		ADD	R0, R0, x0	; Bring R0 (X) into scope.
		BRzp	CONTINUE1	; If R0 (X) is NEG, apply 2's complement.
		NOT	R0, R0
		ADD	R0, R0, x1
		ADD	R4, R4, #-1	; Decrement R4 (sign) by 1, accounting for the negative operand.
		BR	CONTINUE2	; Unconditonally branch to now check the sign for the 2nd operand, R1 (Y).
CONTINUE1	BRp	CONTINUE2	; If R0 (X) is zero, RETURN
		RET
CONTINUE2	ADD	R1, R1, x0	; By this point, R0 (X) is positive so bring R1 (Y) into scope for checking.
		BRzp	CONTINUE3	; If R1 (Y) is negative, apply 2's complement.
		NOT	R1, R1
		ADD	R1, R1, x1
		ADD	R4, R4, #-1	; Decrement R4 (sign) by 1, accounting for the negative operand.
		BR	CONTINUE4	; Unconditionally branch to loop that builds the product.
CONTINUE3	BRp	CONTINUE4	; If R1 (Y) is 0, then CLEAR R2, and RETURN
		AND	R2, R2, x0
		RET
CONTINUE4	ADD	R1, R1, x0	; Bring R1 (Y) into scope.
LOOP1		BRz	CONTINUE5	; If R1 (Y) is not zero,
		ADD	R2, R2, R0	; add R0 (X) into R2 (PRODUCT),
		ADD	R1, R1, #-1	; then decrement R1 (Y) by 1,
		BR	LOOP1		; and loop again.
CONTINUE5	ADD	R4, R4, x0	; Bring R4 (sign) into scope.
		BRnp	CONTINUE6	; If R4 (sign) is 0, then adjust sign of product.
		NOT	R2, R2		
		ADD	R2, R2, x1
		RET
CONTINUE6	RET

DIV		AND	R3, R3, x0	
		AND	R4, R4, x0
		AND	R2, R2, x0
		
		ADD	R0, R0, x0
		BRn	CONTINUE7
		ADD	R1, R1, x0
		BRnz	CONTINUE8
		BR	CONTINUE9
CONTINUE7	RET
CONTINUE8	RET
CONTINUE9	ADD	R2, R2, x1
		ADD	R4, R0, x0
		NOT	R1, R1
		ADD	R1, R1, x1
		ADD	R4, R4, R1
LOOP2		ADD	R4, R4, x0
		BRzp	CONTINUE10
		LDI	R1, Y
		ADD	R4, R4, R1 
		RET
CONTINUE10	ADD	R4, R4, R1
		ADD	R3, R3, x1
		BR	LOOP2

		.END