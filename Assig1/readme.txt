
** VM
    * The following command run the vm:
        -> python3  lc3.py  “obj_folder_path”
    * The vm dumps the memory files in the “obj_folder_path” under “dumps” folder.
    * The vm automatically loads all .obj files and place them in memory "acts like a loader"
    * To assemble multiple .asm files, I did a python script that assemble all .asm files in a folder. The following command is used:
        -> python3 lc3assall.py  "lc3tools_folder"  "asm_folder_path"
    * The lc3assall.py script uses the lc3as in the "lc3tools_folder"

** Notes
    * Multiple .asm files are used as multiple .ORIG directives are not supported in the same file.
    * The PCB is different between problem2 and problem3, as in problem3 the PCB has to be more complicated to implement the yield.
    * The last dump file in problem3 doesn't reflect the latest status in memory as the vm enters a while loop.
    * The PCB addresses are different than the assignment as it has more data. 