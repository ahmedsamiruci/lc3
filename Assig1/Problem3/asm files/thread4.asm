; Thread code
            .ORIG x7000
            AND R1, R1, #0      ; R1 = 0
            ADD R1, R1, #4      ; R1 = 4
            TRAP    x26         ; Yield trap
            ADD R1, R1, #2      ; incremeant by 2      
            HALT
            .END