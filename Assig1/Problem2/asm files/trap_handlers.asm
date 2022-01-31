;; implementation for the HALT trap

                    .ORIG   x0100
HALT_TRAP           TRAP    xFF
                    JSR STOP_CUR_PROC
STOP_CUR_PROC_END   JSR GET_NXT_PRC
GET_NXT_PRC_END     JSR START_PROC
            

;get_next_proc
;inputs = 0
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
            ADD R1, R1, #2      ; R1 <- the next thread address (cur thrd + 2)
            LD R3, CONST_INV_THRD    ; R3 <- invalid thread address
            NOT R3, R3
            ADD R3, R3, #1      ; R3 <- (-R3) i.e. R3 = - x20A
            ADD R2, R1, R3      ; R2 = cur_thread - inv_thread i.e. catch if cur_thread out of boundary
            BRNP check_prc_status   ; negative value means cur_thrd++ is still valid
               ; if the code is here enter a while loop
               ; Log before entering while loop
            TRAP    xFF
            JSR WHL

;; funtion to change the stop the cur thread if it is running
STOP_CUR_PROC
            LD R1, CUR_THRD     ; R1 <- the value of cur thread
            LDR R2, R1,#0       ; R2 <- cur thread status ; 0 or 1, 2
            ADD R3, R2, #-2     ; if status is Running(2) R3 should be 0
            BRNP STOP_CUR_PROC_END   ; exit from function if thread is not running
            LD R2, THRD_TERM  ; R2 <- Terminated value (0)
            STR R2, R1, #0      ; update curr_thread memory location with Ready status
            JSR STOP_CUR_PROC_END

;; start the next thread
;; inputs the next ready thread at R0
;; output none
START_PROC
            ;; R0 points to PCBx[0]
            LD R1, THRD_RUNNING ; R1 <- Running value (2)
            STR R1, R0, #0      ; mem[ PCBx[0] ] = Running ;
                    ; Set the CUR_THRD with the new Thread
            LEA R4, CUR_THRD     ; R4 <- CUR_THRD var address
            STR R0, R4, #0      ; mem[ CURR_THRD ] <- R0
            LDR R2, R0, #1      ; R2 <- mem [ PCBx[1] ] ; R2 <- get the func add from PCBx
            TRAP    xFF         ; Dump memory
            JMP R2             ; start executing the thread function


; While True Loop
WHL         AND R6, R6, #0      ; dummy instn
            JSR WHL             

CUR_THRD        .FILL   x200 ; memory location holding the address of current thread
CONST_INV_THRD  .FILL   x20A
CONST_FRST_THRD .FILL   x200
THRD_READY      .FILL   #1
THRD_RUNNING    .FILL   #2
THRD_TERM       .FILL   #0
                .END