; Thread code
            .ORIG x8000
            AND R1, R1, #0      ; R1 = 0
            ADD R1, R1, #5      ; R1 = 5
            HALT
            .END