; This is the first program in the lab manual
; This program adds the numbers 10+9+8.....+1
; Three registers are used R1, R2 and R3
; R2 is used as the multiplicand register
; R3 is used as the multiplier register
; The final result is stored in R1
		AREA |.text|, CODE
		EXPORT multiplyNumbers10To1
		ENTRY
		
multiplyNumbers10To1
		MOV R1, #0   ; Initialize the result value with 0
		MOV R2, #1   ; Initialize the multiplicand with 1
		MOV R3, #10  ; User R3 as the multiplier, as well as counter or start number
		
multiplyLoop
		MUL R1, R2, R3 ; Multiply R1 and R2 and store in R0
		MOV R2, R1     ; Previous multiplication result is stored into R2 which will be multiplicand next cycle
		SUBS R3, #1		; Change the counter to next values i.e. 10... 9... 8... 7...
		BNE multiplyLoop
		
		END
		