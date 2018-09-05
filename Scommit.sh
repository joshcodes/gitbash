basedir=`pwd`
echo "BASEDIR:$basedir"
modules=`cat .gitmodules | grep "\[submodule" | sed -e s/.*\ \"//g | sed -e s/\"]//g`
echo $modules
for module in $modules; do
	echo "CHECKING OUT:$basedir/$module"
	dir=`echo "$basedir/$module" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
	cd $dir
	if [ `git status | grep -i "Changes not staged for commit" | wc -l` = "0" ]
	then
		echo "No Changes"
	else
		echo "SUBMODULE:$module:Committing"
		git commit -m "$1" -a
	fi
	cd $basedir
	echo "DONE"
	echo
done

