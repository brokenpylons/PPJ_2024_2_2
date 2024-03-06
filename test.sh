#!/bin/bash
pwd

declare -r path=$(dirname $(realpath "$0"))

declare -i err=0

for file in "$path"/examples/example{0..50}.txt
do
    echo "$file"
    cat "$file"
    declare output=$(./run.sh "$file" >(cat -) >/dev/null)
    declare expected="${file%.*}.expected.txt"

    if [[ "$output" == $(cat "$expected") ]]
    then
        echo -e "[OK]\n"
    else
        wdiff <(cat - <<<"$output") "$expected"
        echo -e "[FAIL]\n"
        ((err++))
    fi
done

exit $err
