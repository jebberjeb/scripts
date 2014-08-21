#! /bin/bash
rm -rf .svn-status
svn status > .svn-status
vim -c ":%norm 0dw" .svn-status
cat .svn-status | while read line
do
    svn changelist temp $line
done
echo "enter a commit message:"
read comment
svn commit -m"$comment" --changelist temp
echo "svn commit done!"
