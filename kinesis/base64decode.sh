#!/bin/bash

while read line; do
 echo "$line" | base64 --decode
done
