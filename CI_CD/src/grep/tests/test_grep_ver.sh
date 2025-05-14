#!/bin/bash
SUCCESS=0
FAIL=0
TEST_COUNTER=0
TC_NAME=""
TEST_CASE=""
FLAGS=""
PATTERN=""
FILE=""

function clear_vars(){
    FLAGS=""
    PATTERN=""
    FILE=""
}

#function run_test(){
 #   $TEST_CASE > original_grep$TC_NAME.log
 #   ./s21_$TEST_CASE > s21_grep$TC_NAME.log
#}

function main(){
    
    $TEST_CASE > original_grep$TC_NAME.log
    ./s21_$TEST_CASE > s21_grep$TC_NAME.log

    DIF_RES="$(diff -s original_grep$TC_NAME.log s21_grep$TC_NAME.log)"

    if [ "$DIF_RES" == "Files original_grep$TC_NAME.log and s21_grep$TC_NAME.log are identical" ]
        then
        (( SUCCESS++ ))
        (( TEST_COUNTER++ ))
        echo  ""$TEST_CASE - "Test:"$TC_NAME "FUNCTIONALITY SUCCESS"
        else
        (( FAIL++ ))
        (( TEST_COUNTER++ ))
        echo  ""$TEST_CASE - "Test:"$TC_NAME "FUNCTIONALITY FAIL"
    fi
}

#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-e"
PATTERN="sed"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-e"
PATTERN="a"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-e"
PATTERN="a -e sed"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-e"
PATTERN="a -e at"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-e"
PATTERN="-i"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-v"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-c"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-l"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-l"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#--------------------------------------------------
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-l"
PATTERN="quam"
FILE="tests/1.txt tests/2.txt tests/3.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#-------------------------------------------------- 10
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-n"
PATTERN="quam"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-n"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-n"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-n"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt tests/3.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-h"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-h"
PATTERN="amet"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-h"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-h"
PATTERN="quam"
FILE="tests/1.txt tests/2.txt tests/3.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-s"
PATTERN="quam"
FILE="nothing.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
echo "lorem" > example.txt
FLAGS="-f"
PATTERN="example.txt"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
echo "lorem" > example.txt
echo "ipsum" >> example.txt
FLAGS="-f"
PATTERN="example.txt"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
echo "lorem" > example.txt
FLAGS="-f"
PATTERN="example.txt"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
echo "lorem" > example.txt
echo "quam" > example.txt
FLAGS="-f"
PATTERN="example.txt"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-o"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-iv"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-ic"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-ic"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-in"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-ih"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
rm example.txt
echo "lorem" > example.txt
TC_NAME=$TEST_COUNTER
FLAGS="-if"
PATTERN="example.txt"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
rm example.txt
echo "lorem" > example.txt
TC_NAME=$TEST_COUNTER
FLAGS="-if"
PATTERN="example.txt"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-io"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-vc"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-vl"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-vn"
PATTERN="lorem"
FILE="tests/1.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-vh"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
#clear_vars
#TC_NAME=$TEST_COUNTER
#FLAGS="-vo"
#PATTERN="lorem"
#FILE="tests/1.txt"
#TEST_CASE="grep $FLAGS $PATTERN $FILE"
#rm -rf *.log
#main

#-------------------------------------------------- 
#clear_vars
#TC_NAME=$TEST_COUNTER
#FLAGS="-cl"
#PATTERN="lorem"
#FILE="tests/1.txt"
#TEST_CASE="grep $FLAGS $PATTERN $FILE"
#rm -rf *.log
#main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-cn"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-ch"
PATTERN="amet"
FILE="tests/1.txt tests/2.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-co"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt tests/4.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main
#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-ln"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt tests/4.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-lh"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt tests/4.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-lh"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt tests/4.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

#-------------------------------------------------- 
clear_vars
TC_NAME=$TEST_COUNTER
FLAGS="-lo"
PATTERN="lorem"
FILE="tests/1.txt tests/2.txt tests/4.txt"
TEST_CASE="grep $FLAGS $PATTERN $FILE"
rm -rf *.log
main

rm -rf *.log
rm -rf example.txt
echo "\"FAIL: $FAIL\"" > $PWD/test_log/s21_grep_log.log
echo "SUCCES: $SUCCESS"
echo "FAIL: $FAIL"
echo "ALL: $TEST_COUNTER"
