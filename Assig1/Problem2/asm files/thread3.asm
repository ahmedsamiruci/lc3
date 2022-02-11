; Thread code
            .ORIG x6000
            AND R1, R1, #0      ; R1 = 0
            ADD R1, R1, #3      ; R1 = 3
            HALT
            .END