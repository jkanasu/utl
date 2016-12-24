; -----------------------------------------------------------------
			AREA | Header Data |, DATA ; Start of Data definitions
Lock_Variable DCD 0 ; Word size data    (Define Constant Data)
Jagi_Variable DCD 0 ; Just like that Word size data    (Define Constant Data)

; -----------------------------------------------------------------
			AREA |.text|, CODE, READONLY ; Start of CODE area
			EXPORT mutexLocking

mutexLocking 
			LDR R1,=0xa		; just initialize the register with dummy value
get_lock  	LDR R0, =Lock_Variable 	; Get address of lock variable
			LDREX R1, [R0] 	; Read current lock value into the register
			;DMB 			; Data Memory Barrier, Making sure memory transfer completed before next one start
        
            CMP R1,#0		; our own convention is that the memory location will contain 0 value if the mutex is NOT acquired
            ;ITE EQ			; NOT required because we are on simulator, works well for Thumb ; condition statement TRUE FALSE
			LDREQ R3,=try_to_get_lock	; First time will go to try loop
			LDRNE R3,=get_lock		; Lock is set by another task, try again
			BLX R3		; This will result in infinite loop from the second attempt, me acquiring mutex and again trying to acquire the same mutex
			B get_lock ; This statement is reached ONLY after acquiring lock, The idea is get_lock "again", which means infinite loop

try_to_get_lock  
			MOVS R1, #1		; First thing to do is as per convention set the memory location with 1 value to indicate mutex is acquired
			STREX R2, R1, [R0]	; Load contents of R0 location into R1. The return status is in R2 
			;DMB 				;Data Memory Barrier
			CBZ R2, lock_done 	;Return status of STREX is in R2, if it is 0, that indicates that STREX is exclusive done or lock process succeed
			B get_lock 			;locking process failed, retry
		  
lock_done 
			BX LR 				; return
			END	