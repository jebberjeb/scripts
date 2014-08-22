#! /bin/bash
#
# Use vimdiff to diff two svn revisions of a file.
#
# TODO
# * if rev2 omitted, then rev2 = rev1, rev1 = rev2 - 1
# *     (in other words, diff w/ prev rev)
# *

if [[ $1 == "-h" ]]; then
    echo "Usage: [-h] rev1 [rev2] file"
fi

rev1=$1
rev2=$2
file=$3

echo "rev 1: $rev1 rev 2: $rev2 file: $file"

svn cat -r $rev1 $file > .f1
svn cat -r $rev2 $file > .f2
vimdiff .f1 .f2

rm .f1
rm .f2
