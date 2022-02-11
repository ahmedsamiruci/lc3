; this file contains the threads PCBs
;---------------------------
;--------- PCB Block -------
;---------------------------

;--------- STATUS ----------
;---------  PC -------------
;---------  R1 -------------
;---------  R2 -------------
;---------------------------

;--------- Thread Status ----------
;------ 0x0 == Terminated ---------
;------ 0x1 == Ready      ---------
;------ 0x2 == Running    ---------
;----------------------------------

.ORIG   x0200
App     .FILL   x1          ;App Thread Status
        .FILL   x3000      
        .BLKW   #2

PCB0    .FILL   x0          ;PCB0 Thread Status
        .FILL   x4000       ;PCB0 Thread code location
        .BLKW   #2

PCB1    .FILL   x0
        .FILL   x5000
        .BLKW   #2

PCB2    .FILL   x0
        .FILL   x6000
        .BLKW   #2

PCB3    .FILL   x0
        .FILL   X7000
        .BLKW   #2

PCB4    .FILL   x0
        .FILL   x8000
        .BLKW   #2
PCB_END .END