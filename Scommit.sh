basedir=`pwd`
echo "BASEDIR:$basedir"
modules=`cat .gitmodules | grep "\[submodule" | sed -e s/.*\ \"//g | sed -e s/\"]//g`
echo $modules
for module in $modules; do
	dir=`echo "$basedir/$module" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
	cd $dir

	if [ `git status | grep -i "Untracked files" | wc -l` -gt 0 ]
	then
		echo "SUBMODULE:$module:Adding files"
		git add .
	fi

	if [ `git status | grep -i 'Changes not staged for commit\|Changes to be committed' | wc -l` -gt 0 ]
	then
		echo "SUBMODULE:$module:Committing"
		git commit -m "$1" -a
	fi

	cd $basedir
done

if [ `git status | grep -i "Untracked files" | wc -l` -gt 0 ]
then
	echo "SUBMODULE:$module:Adding files"
	git add .
fi

if [ `git status | grep -i 'Changes not staged for commit\|Changes to be committed' | wc -l` = "0" ]
then
	echo "No Changes to base project"
else
	echo "Committing base project"
	git commit -m "$1" -a
fi

