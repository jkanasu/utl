; This is a dummy file to be "Added to the Project", it contains a __main function
; Keep the functionality minimum in this file
; Idea is to call other functions from this main file
; comment out the applicable IMPORT and the Branching statements

		AREA |.text|, CODE
		EXPORT __main
		ENTRY
		
__main

		MOV R0, #0 ; This is a dummy instruction so that we can debug the flow
		MOV R0, #15 ; This is a dummy instruction so that we can debug the flow

		; Comment out the below line pairs if you want to exclude
		IMPORT addNumbers10To1
		LDR R0, =addNumbers10To1
		BL addNumbers10To1; BLX R0  ;
		
		MOV R0, #0 ; This is a dummy instruction so that we can debug the flow
		MOV R0, #15 ; This is a dummy instruction so that we can debug the flow

		; Comment out the below line pairs if you want to exclude
		IMPORT multiplyNumbers10To1
		LDR R0, =multiplyNumbers10To1
		BX R0 	;BL multiplyNumbers10To1
		
		MOV R0, #0 ; This is a dummy instruction so that we can debug the flow
		MOV R0, #15 ; This is a dummy instruction so that we can debug the flow

		;B . ; Infinite loop Uncomment this line if you want to keep the program running indefinitely
		END
		

