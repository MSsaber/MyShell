#!/bin/bash

coutSetting="N"
fileType="NoType";
IsfileRemove="N";
IsDebug="N";
fileName="NoFile";
OutFileIndex=-1;
removeFileName="NoFile";

CheckFileType(){
    if [ $fileName != "cpp" ] && [ $fileName != "c" ]
    then
        echo "Error : Current file type is not supported!";
        exit 1;
    fi
}

FireFile(){
    if [ $coutSetting = "N" ]
    then
        if [ -f "./a.out" ] && [ $fileName = "cpp" ]
        then
            echo "WARNING : excutable already exists or not regenerated?[Y/N]"
            read IsfileRemove;
            removeFileName="./a.out";
        elif [ -f "./a.out" ] && [ $fileName = "c" ]
        then
            echo "WARNING : excutable already exists or not regenerated?[Y/N]"
            read IsfileRemove;
            removeFileName="./a.out";
        fi
    fi
    
    if [ $IsfileRemove = "Y" ] || [ $IsfileRemove = "y" ]
    then
        if [ $removeFileName != "NoFile" ]
        then
            rm $removeFileName;
            echo "exxcutable file removed!";
        fi
    fi
    
    if [ $fileName = "cpp" ]
    then
        g++ $*;
    elif [ $fileName = "c" ]
    then
        gcc $*;
    fi

}

Run(){
    echo "Begin Running..."
    echo ""
    if [ $fileName = "cpp" ] || [ $fileName = "c" ]
    then
        ./$removeFileName;
    fi
}

CheckArgs(){
    #whether the count of parameters is valid;
    if [ $# == 0 ]
    then
        echo "Error : number of invalid parameters!"
        exit 1;
    fi

    ValidIndex=1;
    ArgIndex=0;
    for arg in $*
    do
        if [ -f $arg ] && [ "${arg##*.}"x = "cpp"x ]
        then
            fileName="cpp";
        elif [ -f $arg ] && [ "${arg##*.}"x = "c"x ]
        then           
            fileName="c";
        elif [ $arg = "-o" ]
        then
            coutSetting="Y";
            OutFileIndex=$[$ArgIndex+1];
        elif [ $OutFileIndex -ge $ValidIndex ] && [ -f $arg ]
        then
            echo "WARNING : excutable already exists or not regenerated?[Y/N]"
            read IsfileRemove;
            removeFileName=$arg;
        elif [ $arg = "-D" ]
        then
            IsDebug="Y";
        fi
        let "ArgIndex++";
    done

    if [ $fileName = "NoFile" ]
    then
        echo "Error : the file does not exist in the current folder!";
        exit 1;
    fi
}

CheckArgs $*;
CheckFileType;
FireFile $*;
Run;
