#!/bin/bash

for folder in tests/*
do
    rm -rf "$folder"/*.alf.json
    rm -rf "$folder"/*.out
    for file in "$folder"/*.ast.json
    do
        echo $file
        node ../index.js "$file" "$folder"/$(basename $file .ast.json).json
    done
done