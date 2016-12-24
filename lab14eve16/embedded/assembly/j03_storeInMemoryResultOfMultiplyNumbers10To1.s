; This program multiplies the numbers 10+9+8.....+1
; At the same time stores the results in a give memory location, overwrites location with every loop
; Three registers are used R1, R2 and R3
; R2 is used as the multiplicand register
; R3 is used as the multiplier register
; The final result is stored in R1
		AREA |Header Data|, DATA
		ALIGN 4
		ENTRY
MYDATA  EQU 0x10001000 ; We should know the typical data memory block address to manually set the value
MYDATA1 DCD 0 ; DCD will correctly allocate the memory in data block, the above AREA should declare that it is DATA
		
		AREA |.text|, CODE
		EXPORT storeInMemoryResultOfMultiplyNumbers10To1
		
storeInMemoryResultOfMultiplyNumbers10To1
		MOV R1, #0   ; Initialize the result value with 0
		MOV R2, #1   ; Initialize the multiplicand with 1
		MOV R3, #10  ; Use R3 as the multiplier, as well as counter or start number
		LDR R4, =MYDATA ; Use R4 as the address pointer
		LDR R5, =MYDATA1 ;  DCD allocation is in data block, this also can be used
		
multiplyLoop
		MUL R1, R2, R3 ; Multiply R2 and R3 and store in R1
		MOV R2, R1     ; Previous multiplication result is stored into R2 which will be multiplicand next cycle
		STR R1,[R4]		; The contents of R1 into RLDR R
		SUBS R3, #1		; Change the counter to next values i.e. 10... 9... 8... 7...
		BNE multiplyLoop
		BX LR ; This will load the LR into the PC, hence return to the calling function
		END
		