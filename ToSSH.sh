tail=`git remote -v | grep -v fetch | sed -e 's/.*github.com\///g' | sed -e 's/ .*//g'`
newrepo="git@github.com:/$tail"
git remote set-url origin $newrepo
echo $newrepo
