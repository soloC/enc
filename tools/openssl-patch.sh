#!/bin/bash
INPUT_PATH=./
OUTPUT_PATH=../output
PASSWD=
if [ "$2" != "" ]
then
    INPUT_PATH=$2
fi

if [ "$3" != "" ]
then
    OUTPUT_PATH=$3
fi


function usage()
{
        echo "Usage $0 [enc|dec] input-path output-path passwd"
        exit
}

case "$1" in
    enc)
        if [ "$4" == "" ]
        then
            echo "Usage $0 enc input-path output-path passwd"
        else
            PASSWD=$4
        fi
        for file in `find $INPUT_PATH -name "*.patch"`
        do
            openssl aes-256-cbc -e -in $file -out $file.enc -pass pass:"$PASSWD" -pbkdf2
        done
        mkdir $OUTPUT_PATH
        find $INPUT_PATH -name "*.enc" | cpio -pdum $OUTPUT_PATH
        find $INPUT_PATH -name "*.enc" | xargs rm
        echo "Encrypt $INPUT_PATH document files in $OUTPUT_PATH OK"
        ;;
    dec)
        if [ "$4" == "" ]
        then
            echo "Usage $0 dec input-path output-path passwd"
        else
            PASSWD=$4
        fi
        mkdir $OUTPUT_PATH -p
        cp $INPUT_PATH/* $OUTPUT_PATH -dr
        cd $OUTPUT_PATH
        for file in `ls . -c`
        do
            openssl aes-256-cbc -d -in $file -out $(ls $file | awk -F ".enc$" '{print $1}') -pass pass:"$PASSWD" -pbkdf2
        done
        cd -
        find $OUTPUT_PATH -name "*.enc" | xargs rm
        echo "Decrypt $INPUT_PATH document files OK"
        ;;
    *)
        usage
        ;;
esac

