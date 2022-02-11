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
App     .FILL   x2          ;App Thread Status MUST be Running
        .FILL   x3000      
        .BLKW   #2

PCB0    .FILL   x1          ;PCB0 Thread Status
        .FILL   x4000       ;PCB0 Thread code location
        .BLKW   #2

PCB1    .FILL   x1
        .FILL   x5000
        .BLKW   #2

PCB2    .FILL   x1
        .FILL   x6000
        .BLKW   #2

PCB3    .FILL   x1
        .FILL   X7000
        .BLKW   #2

PCB4    .FILL   x1
        .FILL   x8000
        .BLKW   #2
PCB_END .END