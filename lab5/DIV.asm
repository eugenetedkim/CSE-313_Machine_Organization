DIV		ADD	R1, R1, x0				; 1. exit loop if x<0 OR y<=0
		BRnp	CONTINUE7				; 2. else valid=1
		ADD	R4, R4, R0				; 3. 
		ADD	R2, R2, x1
		RET
CONTINUE7	BRp	CONTINUE8
		RET
CONTINUE8	NOT	R1, R1
		ADD	R1, R1, x1
		ADD	R4, R0, x0
		ADD	R2, R2, x1
LOOP2		ADD	R4, R4, R1
		BRn	CONTINUE9
		ADD	R4, R4, R1
		ADD	R3, R3, x1
		BR	LOOP2
CONTINUE9	RET