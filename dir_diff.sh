#!/bin/bash
function timestamp {
    date +"%Y-%m-%d_%H-%M-%S"
}

echo "diffing files..."
ls $1 | grep ".cls$" > dir1.tmp;
ls $2 | grep ".cls$" > dir2.tmp;
TS="$(timestamp)"
while read line; do
    DIR2HASFILE="$(grep -x "${line}$" < dir2.tmp)"
    SIZE=${#DIR2HASFILE}
    SIZE=$(($SIZE + 0)) 
    if [ $SIZE = 0 ]; then
        echo "${line} not found in ${2}" >> "${3}/nonexistant_report_${TS}.txt" 
    fi
    diff -N -s "${1}/${line}" "${2}/${line}" > "${3}/${line}_diff.txt"
done < dir1.tmp
rm dir1.tmp dir2.tmp;

