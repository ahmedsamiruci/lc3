import os
import subprocess
from sys import exit, stdin, stdout, argv

def getFilesList( fileDir, fileExt):
    filesList = [os.path.join(fileDir, _) for _ in os.listdir(fileDir) if _.endswith(fileExt)]
    return filesList

def start(assDir, userDir):
    filesList = getFilesList(userDir, '.asm')
    for filename in filesList:
        assemble_file(assDir, filename)

def assemble_file(assDir, filename):
    print(filename)
    val = subprocess.run([os.path.join(assDir,'lc3as'), filename])

def main():
    
    if len(argv) < 3:
        print("please input the following: Assmebler directory and the directory of .asm files")
        exit()    

    start(argv[1], argv[2])


if __name__ == "__main__":
    main()