;; asembly file for assigning trap service routines
            .ORIG   x25
HALT_TRAP   .FILL   x0100  ;; The address for the HALT_TRAP function
YIELD_TRAP  .FILL   x011E   ;; The address for the YIELD_TRAP function
            .END