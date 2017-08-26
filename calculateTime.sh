#!/bin/bash
#    calculateTime.sh - Easily calculate time for time complexity analysis and get a data file for plotting graph
#    Copyright (C) 2017  Ashutosh Sathe (2ashutoshbs@gmail.com)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see http://www.gnu.org/licenses/.
set -eu
set -o pipefail
#   Set these variables properly to get a proper output
#   PROGRAM - Program name WITHOUT .c extension
#   DELETE_PREVIOUS_DATAFILE - set this to true if you want to remove older datafile having same name
#   GENERATE_RANDOM_DATA - Will generate random data using random.c and store them in files
#   USE_TIME_FUNCTION - Will use time function for calculating time, If you don't to use time command to calculate time, set this to false
#   numRecords array - Number of records to be sorted

PROGRAM="sort1"
DELETE_PREVIOUS_DATAFILE=true
DATA_NAME="data0"
GENERATE_RANDOM_DATA=false
USE_TIME_FUNCTION=true
declare -a numRecords=("1000" "2500" "5000" "7500" "10000" "15000" "20000" "25000" "30000" "35000" "40000" "45000" "50000" "55000" "60000" "65000" "80000" "90000" "100000" "160000" "250000" "320000" "500000" "1000000" )

#   Start doing stuff now
if [ "$DELETE_PREVIOUS_DATAFILE" = true ]
then
    rm -rf $DATA_NAME
fi
gcc -Wall $PROGRAM.c -o $PROGRAM
if [ "$GENERATE_RANDOM_DATA" = true ]
then
    echo -e "Generating datafiles..."
    for((i = 0; i < ${#numRecords[@]}; ++i))
    do
        gcc -Wall random.c -o random
        echo ${numRecords[i]} ${numRecords[i]} | ./random > ${numRecords[i]}.txt
        echo -e "${numRecords[i]} Records Generated into file ---> ${numRecords[i]}.txt"
    done
fi
if [ "$USE_TIME_FUNCTION" = false ]
then
    echo -e "Calculating time without \"time command\" ..."
    for ((i = 0; i < ${#numRecords[@]}; ++i))
    do
        echo -e "For ${numRecords[i]} records :\n"
        echo ${numRecords[i]} | tr '\n' '\t' >> data0
        cat ${numRecords[i]}.txt | ./$PROGRAM | tee -a $DATA_NAME
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    done
fi
if [ "$USE_TIME_FUNCTION" = true ]
then
    echo -e "Calculating time without \"time command\" ..."
    for ((i = 0; i < ${#numRecords[@]}; ++i))
    do
        echo -e "For ${numRecords[i]} records :\n"
        echo ${numRecords[i]} | tr '\n' '\t' >> data0
        cat ${numRecords[i]}.txt | { /usr/bin/time -f "%U" ./$PROGRAM ;} |& tee -a $DATA_NAME
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    done
fi
