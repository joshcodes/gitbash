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
		git checkout master > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			git pull origin master > /dev/null 2>&1
			if [ $? -gt 0 ]; then
				echo "PULL FAILED!!!!"
			fi
		else
			echo "CHECKOUT FAILED!!!!"
		fi
	else
		echo "SUBMODULE:$module:IS NOT CLEAN"
	fi
	cd $basedir
	echo "DONE"
done

