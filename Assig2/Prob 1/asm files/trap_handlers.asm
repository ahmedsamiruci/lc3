;; implementation for the HALT trap

                    .ORIG   x0100
HALT_TRAP               ; store the current process status
                    LD R6, CUR_THRD     ; R6 <- the value of cur thread
                    STR R7, R6, #1      ; Store the thread PC [R7] into the PCBx[1] to restore execution later
                    STR R1, R6, #2      ; Store R1 into PCBx[2]
                    STR R2, R6, #3      ; Store R2 into PCBx[3]
                    TRAP    xFF

                    JSR STOP_CUR_PROC
STOP_CUR_PROC_END   JSR SCHEDULER


;; The scheduler function
SCHEDULER           JSR GET_NXT_PRC
GET_NXT_PRC_END     JSR RESUME_PROC      
                                    
                                
;get_next_proc
;inputs = none
;output the next ready process address = R0
GET_NXT_PRC
            LD R1, CUR_THRD    ; R1 <- the value of cur thread
check_prc_status 
            LDR R2, R1,#0       ; R2 <- cur thread status ; 0 or 1, 2
            ADD R3, R2, #-1     ; if status is ready(1) R3 should be 0
            BRNP increment_process
            ADD R0, R1, #0      ; R0 <- the next ready thread address
            JSR GET_NXT_PRC_END ; end of the funtion
increment_process
            ADD R1, R1, #4      ; R1 <- the next thread address (cur thrd + 4)
            LD R3, CONST_INV_THRD    ; R3 <- invalid thread address
            NOT R3, R3
            ADD R3, R3, #1      ; R3 <- (-R3) 
            ADD R2, R1, R3      ; R2 = cur_thread - inv_thread i.e. catch if cur_thread out of boundary
            BRNP check_prc_status   ; negative value means cur_thrd++ is still valid
            LD R1, CONST_FRST_THRD ; R1 <-first thread; to make the list circuler
            JSR check_prc_status


;; funtion to change the stop the cur thread if it is running
STOP_CUR_PROC
            LD R1, CUR_THRD     ; R1 <- the value of cur thread
            LDR R2, R1,#0       ; R2 <- cur thread status ; 0 or 1, 2
            ADD R3, R2, #-2     ; if status is Running(2) R3 should be 0
            BRNP STOP_CUR_PROC_END   ; exit from function if thread is not running
            LD R2, THRD_TERM  ; R2 <- Terminated value (0)
            STR R2, R1, #0      ; update curr_thread memory location
            JSR STOP_CUR_PROC_END


;----------------------------------------------------------------
;----------------------------------------------------------------
;------------------  YIELD_TRAP  --------------------------------
;----------------------------------------------------------------
;----------------------------------------------------------------

YIELD_TRAP              ; store the current process status
                        LD R6, CUR_THRD     ; R6 <- the value of cur thread
                        STR R7, R6, #1      ; Store the thread PC [R7] into the PCBx[1] to restore execution later
                        STR R1, R6, #2      ; Store R1 into PCBx[2]
                        STR R2, R6, #3      ; Store R2 into PCBx[3]
                                ;LD R6, YIELD_MARK   ; pass to SCHEDULER function the caller variable
                        JSR YIELD_CUR_PROC
YIELD_CUR_PROC_END      JSR SCHEDULER

;; funtion to yield the cur thread if it is running by make it status as ready
YIELD_CUR_PROC
            LD R1, CUR_THRD     ; R1 <- the value of cur thread
            LDR R2, R1,#0       ; R2 <- cur thread status ; 0 or 1, 2
            ADD R3, R2, #-2     ; if status is Running(2) R3 should be 0
            BRNP YIELD_CUR_PROC_END   ; exit from function if thread is not running
            LD R2, THRD_READY  ; R2 <- Ready value (1)
            STR R2, R1, #0      ; update curr_thread memory location with Ready status
            JSR increment_process

;; resume the next thread
;; inputs the next ready thread at R0
;; output none
RESUME_PROC
            ;; R0 points to PCBx[0]
            LD R1, THRD_RUNNING ; R1 <- Running value (2)
            STR R1, R0, #0      ; mem[ PCBx[0] ] = Running ;
                    ; Set the CUR_THRD with the new Thread
            LEA R4, CUR_THRD     ; R4 <- CUR_THRD var address
            STR R0, R4, #0      ; mem[ CURR_THRD ] <- R0

                ; Restore the registers from PCB 
            LDR R6, R0, #1      ; R6 <- mem [ PCBx[1] ] ; R6 <- get the func add from PCBx
            LDR R1, R0, #2      ; R1 <- PCBx[2]
            LDR R2, R0, #3      ; R2 <- PCBx[3]
                
            TRAP    xFF         ; Dump memory
                ; Switch to User Mode
            AND R5, R5, #0      ; R5 <- 0 [The user mode value of MR_SM register]
            STI R5, MR_SM_ADDR  ; Mem[ MR_SM_ADDR ] = 0
            
            JMP R6             ; start executing the thread function


; While True Loop
WHL         AND R6, R6, #0      ; dummy instn
            JSR WHL             

CUR_THRD        .FILL   x200 ; memory location holding the address of current thread
CONST_INV_THRD  .FILL   x218
CONST_FRST_THRD .FILL   x200
THRD_READY      .FILL   #1
THRD_RUNNING    .FILL   #2
THRD_TERM       .FILL   #0
MR_SM_ADDR      .FILL   xFE04   ; Memory Mapped address for Supervisor Mode register
                .END