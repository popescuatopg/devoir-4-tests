#!/bin/bash

dir="$(dirname $0)"

function run_test {
    rm -rf output.*
    filename="$dir/tests/$1"

    touch ./output.json
    cd ..

    inputname="$(dirname $filename)/$(basename $1 .alf).alf.ast.json"

    astoutputname="$(dirname $filename)/$(basename $1).json"
    echo $astoutputname
    
    echo Running $filename
    ./gradlew run -q --args="devoir-4-tests/$inputname devoir-4-tests/$astoutputname"

    cd ./devoir-4-tests/
    # ERROR=0

    # if node verify.js "$astoutputname" "$outputname" &> output.report;
    # then
    #    echo "Correct"
    # else
    #     cat $outputname
    #     cat output.report
    #     echo "Your output                                                   | Correct output"
    #     diff --ignore-space-change --side-by-side --suppress-common-lines "$outputname" "$astoutputname"
    #     ERROR=1
    # fi
    # rm $outputname
    rm -rf output.* 
    rm -rf error
    # return $ERROR
}

if [ $# -lt 1 ];
then
    echo "Running all tests"
    for folder in $(cd $dir && find tests -mindepth 1 -maxdepth 1 -type d | sort)
    do
        for file in $(cd $dir/$folder && find . -mindepth 1 -maxdepth 2 -type f -name '*.alf')
        do
            # echo file $(basename $folder)/$(basename $file)
            newname=$(basename $folder)
            if [[ $newname = 4* ]];
            then
              run_test $newname/$(basename $file)
            fi
        done
    done
else
    run_test $1
fi
