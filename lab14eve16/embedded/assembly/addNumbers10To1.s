; This is the first program in the lab manual
; This program adds the numbers 10+9+8.....+1
; Two registers are used R1 and R2
; The final result is stored in R1
		AREA |.text|, CODE
		EXPORT addNumbers10To1
		ENTRY
		
addNumbers10To1
		MOV R1, #0	; Initialize the result sum to 0
		MOV R2, #10 ; Use R2 as the counter or start number
		
addLoop
		ADD R1, R2 ; Add the numbers one by one to R1
		SUBS R2, #1 ; R1 will contain the next number
		BNE addLoop
		BX LR ; This will load the LR into the PC, hence return to the calling function
		
		END
