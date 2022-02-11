;; application file

        .ORIG   x3000
        LD R2, WM1
        LDI R3, POINTER
        AND R1, R1, #0
        ADD R1, R1, 10
        ST R1, WRITE1
        STI R1, POINTER2
        HALT


WM1         .FILL xA5A5
WM2         .FILL x5A5A
POINTER     .FILL WM1
WRITE1      .BLKW  1
POINTER2    .FILL WM1

        .END