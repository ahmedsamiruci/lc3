; Thread code
            .ORIG x6000
            AND R1, R1, #0      ; R1 = 0
            ADD R1, R1, #3      ; R1 = 3
            STI R1, MR_SM_ADDR  ; Mem [ xFE04 ] = R1
            STI R1, OS_MEM_LOC  ; Mem [ x200 ] = R1  ;Corrupt OS Memory location
            HALT


MR_SM_ADDR  .FILL   xFE04   ; Memory Mapped address for Supervisor Mode register
OS_MEM_LOC  .FILL   x200    
            .END