#!/bin/bash

if [ -f "./a.out" ]
then
    echo "File exited,do you want create new? [Y/N]";
    read res;
    if [ $res = "y" ] || [ $res = "Y" ]
    then
        rm ./a.out;
        g++ $1;
    else
        echo "$res";
    fi
else
    g++ $1;
fi
