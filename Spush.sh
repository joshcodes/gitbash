basedir=`pwd`
echo "BASEDIR:$basedir"
modules=`cat .gitmodules | grep "\[submodule" | sed -e s/.*\ \"//g | sed -e s/\"]//g`
echo $modules
for module in $modules; do
	echo "PUSHING:$basedir/$module"
	dir=`echo "$basedir/$module" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
	cd $dir

	if [ `git remote -v | grep -i "https://github.com" | wc -l` -gt 0 ]
	then
		echo "Converting to SSH repo"
		ToSSH.sh
	fi

	if [ `git status | grep -i "Changes not staged for commit" | wc -l` = "0" ]
	then
		git checkout master > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			if [ `git push origin master | grep -i "Everything up-to-date" | wc -l` = "0" ]
			then
				echo "Already up to date"
			else
				if [ $? -gt 0 ]; then
					echo "PULL FAILED!!!!"
				else
					echo "Updated"
				fi
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

