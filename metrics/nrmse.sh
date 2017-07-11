#!/bin/bash

set -e
set -u

if [ $# != 2 ]
then
    echo "Usage: $0 <im1> <im2>"
    exit 1
fi

im1=$1
im2=$2

diff=`mktemp diff-XXXX.nii.gz`
sqr=`mktemp sqr-XXXX.nii.gz`

meanimage=$(fslstats ${im1} -m)
fslmaths ${im1} -sub ${im2} -sqr ${diff}
meandiff=$(fslstats ${diff} -m)

echo "scale=10; sqrt(${meandiff})/${meanimage}" | bc

\rm ${diff} ${sqr}