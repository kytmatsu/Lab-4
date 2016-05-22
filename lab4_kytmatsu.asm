;Kyle Matsumoto
;This is lab 4.
;Section 4
;Dahpne Victor
;Partner: Tyler Ebding




;start at x 3000
.ORIG   x3000


START:
; clear all registers that we may use
	AND	R0, R0, 0
	AND	R1, R0, 0
	AND	R2, R0, 0
	AND	R3, R0, 0
	AND	R4, R0, 0
	AND	R5, R0, 0
	AND	R6, R0, 0
	AND	R7, R0, 0

; print out PROMPT
	LEA	R0, PROMPT
	PUTS

; get a user-entered character (result in R0)
; echo it back right away (otherwise it isn't visible)
	GETC
	PUTC
	ADD R1, R0, R1
	LD R5,ASCIIOFFSET
;	ADD R3, R0, -15
;	ADD R3, R3, -15
;	ADD R3, R3, -15
;	BRn DONE1:
;	ADD R6, R6,1
;	DONE1:
;	ADD R1,R5,R1

; store entered string (otherwise it may be overwritten)
	ST	R0, USERINPUT

; get a user-entered character (result in R0)
; echo it back right away (otherwise it isn't visible)
	GETC
	PUTC
	ADD R2, R0, R2
	ADD R2,R5,R2

; multiply to get 10's place
	JSR	MULT10
	ST	R4, MULT10VAL
	STI 	R4, MULTADDR1

; store entered string (otherwise it may be overwritten)
	ST	R0, USERINPUT1


; print out a newline and some other stuff
	LEA	R0, NEWLINE1
	PUTS

; ADD TOGETHER YOUR 10'S PLACE AND 1'S PLACE DIGITS TO GET AN INT
	ADD	R4,R2,R4
	ST	R4,INT1
	STI	R4,INT1ADDR

; clear all registers that we may use
	AND	R0, R0, 0
	AND	R1, R0, 0
	AND	R2, R0, 0
	AND	R3, R0, 0
	AND	R4, R0, 0
	AND	R5, R0, 0
	AND	R6, R0, 0
	AND	R7, R0, 0

; print out PROMPT
	LEA	R0, PROMPT
	PUTS

; get a user-entered character (result in R0)
; echo it back right away (otherwise it isn't visible)
	GETC
	PUTC
	ADD R1, R0, R1
	LD R5,ASCIIOFFSET
	ADD R1,R5,R1

; store entered string (otherwise it may be overwritten)
	ST	R0, USERINPUT3


; multiply to get 10's place
	JSR	MULT10
	ST	R4, MULT10VAL2
	STI 	R4, MULTADDR2

; get a user-entered character (result in R0)
; echo it back right away (otherwise it isn't visible)
	GETC
	PUTC
	ADD R2, R0, R2
	ADD R2,R5,R2

; store entered string (otherwise it may be overwritten)
	ST	R0, USERINPUT4

; print out a newline and some other stuff
	LEA	R0, NEWLINE1
	PUTS

; ADD TOGETHER YOUR 10'S PLACE AND 1'S PLACE DIGITS TO GET AN INT
	ADD	R4,R2,R4
	ST	R4,INT2
	STI	R4,INT2ADDR

; clear all registers that we may use
	AND	R0, R0, 0
	AND	R1, R0, 0
	AND	R2, R0, 0
	AND	R3, R0, 0
	AND	R4, R0, 0
	AND	R5, R0, 0
	AND	R6, R0, 0
	AND	R7, R0, 0

; Bit shift Your first int after loading
	LD	R1, INT1
	JSR	MULT2
	ST 	R1, BITS1
	ST 	R3,EXP1
	JSR 	EXPSHF
	AND	R1,R1,0
	AND 	R3,R3,0
	

; Bit shift Your second int after loading
	LD	R1, INT2
	JSR	MULT2
	ST 	R1, BITS2
	ST 	R3, EXP2
	JSR 	EXPSHF
	AND	R1,R1,0
	HALT

;declare Multiplication x 10
MULT10:	 AND R0,R0,0
	 ADD R0,R0,10
;MULTIPLICATION LOOP
M10LOOP: ADD R4, R4, R1
	 ADD R0,R0,-1
	 ADD R3, R3,1
	 BRp M10LOOP
	 RET

;declare Multiplication X 2
MULT2:	AND R0,R0,0
	AND R6,R6,0
	LD  R6, MMASK
	ADD R0,R0,10 
	ADD R0,R0,15
;MULTIPLICATION LOOP
M2LOOP:  ADD R1, R1, R1 ; Mult by 2 to shift bit
	 ADD R0,R0,-1
	 AND R1, R1, R6 ; check against MASK
	 BRz M2LOOP
	 RET
;DECLARE EXPONENT SHIFTER
EXPSHF:	AND R0,R0,0
	ADD R0,R0,10 
EXPSHFLOOP:  
	ADD R3, R3, R3 ; Mult by 2 to shift bit
	ADD R0,R0,-1
	BRp EXPSHFLOOP
	RET

;declare Multiplication
MULT:	AND R0,R0,0
	ADD R0,R0,R1
;MULTIPLICATION LOOP
MLOOP:	ADD R4, R4, R2
	ADD R0,R0,-1
	BRp MLOOP
	RET

;declare division
DIV:	AND R0, R0, 0
	ADD R0,R0,R1
	AND R6, R0, 0
;DIVISION LOOP
DLOOP:	ADD R6,R6,1
	ADD R0,R0,R5
	BRp DLOOP
;IF POSITIVE VALUE KEEP LOOPING
;ELSE KEEP ON GOING TO ZERO
	BRz STORE
	ADD R0,R0,R2
	ADD R6,R6,-1
STORE:;	STI R0,REMADDR
      ;	STI R6,DIVADDR
	RET




; variables
USERINPUT:	.FILL	0
USERINPUT1:	.FILL	0
USERINPUT3:	.FILL	0
USERINPUT4:	.FILL	0
ASCIIOFFSET:	.FILL   #-48
EXPOFFSET:	.FILL	#25
MULT10VAL:	.FILL	0
MULT10VAL2:	.FILL	0
MMASK		.FILL	b0000010000000000
INT1:		.FILL	0
INT2:		.FILL	0
EXP1:		.FILL	0
EXP2:		.FILL	0
BITS1:		.FILL	0
BITS2:		.FILL	0
INT1ADDR:	.FILL	X3201
INT2ADDR:	.FILL	X3202
MULTADDR1:	.FILL   x3100
MULTADDR2:	.FILL   x3101

; strings
NEWLINE:	.STRINGZ "\n--> ";
NEWLINE1:	.STRINGZ "\n";
GREETING:	.STRINGZ	"Welcome."
PROMPT:		.STRINGZ	"Please enter a number between -99 to +99: "
USERSTRING:	.STRINGZ	" <-- is the number you entered.\n"
USERSTRING1:	.STRINGZ	" <-- is the number you entered.\n"


; end of code
	.END
