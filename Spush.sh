basedir=`pwd`
echo "BASEDIR:$basedir"
modules=`cat .gitmodules | grep "\[submodule" | sed -e s/.*\ \"//g | sed -e s/\"]//g`
echo $modules
for module in $modules; do
	dir=`echo "$basedir/$module" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
	cd $dir

	if [ `git remote -v | grep -i "https://github.com" | wc -l` -gt 0 ]
	then
		echo "SUBMODULE:$module:Converting to SSH repo"
		ToSSH.sh
	fi

	git checkout master > /dev/null 2>&1
	if [ $? -eq 0 ]
	then
		if [ `git status | grep -i "Your branch is ahead of" | wc -l` -gt 0 ]
		then
			git push origin master > /dev/null 2>&1
			if [ $? -gt 0 ]
			then
				echo "SUBMODULE:$module:PUSH FAILED!!!!"
			else
				echo "SUBMODULE:$module:Updated"
			fi
		fi
	fi
	cd $basedir
done

