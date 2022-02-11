; Thread code
            .ORIG x4000
            AND R1, R1, #0      ; R1 = 0
            ADD R1, R1, #1      ; R1 = 1
            HALT
            .END