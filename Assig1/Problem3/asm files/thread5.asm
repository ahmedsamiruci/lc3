; Thread code
            .ORIG x8000
            AND R1, R1, #0      ; R1 = 0
            ADD R1, R1, #5      ; R1 = 5
            TRAP    x26         ; Yield trap
            ADD R1, R1, #2      ; incremeant by 2      
            HALT
            .END