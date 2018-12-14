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

MULT		ADD	R4, R4, x1
		ADD	R0, R0, x0
		BRzp	CONTINUE1
		NOT	R0, R0
		ADD	R0, R0, x1
		ADD	R4, R4, #-1
		BR	CONTINUE2
CONTINUE1	BRp	CONTINUE2
		AND	R2, R2, x0
		LDI	R0, X
		RET
CONTINUE2	ADD	R1, R1, x0
		BRzp	CONTINUE3
		NOT	R1, R1
		ADD	R1, R1, x1
		ADD	R4, R4, #-1
		BR	CONTINUE4
CONTINUE3	BRp	CONTINUE4
		AND	R2, R2, x0
		LDI	R1, Y
		RET
CONTINUE4	ADD	R1, R1, x0
LOOP1		BRz	CONTINUE5
		ADD	R2, R2, R0
		ADD	R1, R1, #-1
		BR	LOOP1
		RET
CONTINUE5	ADD	R4, R4, x0
		BRnp	CONTINUE6
		NOT	R2, R2
		ADD	R2, R2, x1
		LDI	R0, X
		LDI	R1, Y
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