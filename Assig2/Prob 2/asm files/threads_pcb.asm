; this file contains the threads PCBs
;---------------------------
;--------- PCB Block -------
;---------------------------

;--------- STATUS ----------
;---------  PC -------------
;---------  MPU ------------
;---------  R1 -------------
;---------  R2 -------------
;---------  RSVD -----------
;---------------------------

;--------- Thread Status ----------
;------ 0x0 == Terminated ---------
;------ 0x1 == Ready      ---------
;------ 0x2 == Running    ---------
;----------------------------------

.ORIG   x0200
App     .FILL   x2          ;App Thread Status MUST be Running
        .FILL   x3000
        .FILL   x1          ; MPU value to access x3000 address space   
        .BLKW   #3

PCB0    .FILL   x1          ;PCB0 Thread Status
        .FILL   x4000       ;PCB0 Thread code location
        .FILL   x2          ; MPU value to access x4000 address space 
        .BLKW   #3

PCB1    .FILL   x1
        .FILL   x5000
        .FILL   x3          ; MPU value to access x5000 address space 
        .BLKW   #3

PCB2    .FILL   x1
        .FILL   x6000
        .FILL   x4          ; MPU value to access x6000 address space 
        .BLKW   #3

PCB3    .FILL   x1
        .FILL   X7000
        .FILL   x5          ; MPU value to access x7000 address space 
        .BLKW   #3

PCB4    .FILL   x1
        .FILL   x8000
        .FILL   x6          ; MPU value to access x8000 address space 
        .BLKW   #3
PCB_END .END