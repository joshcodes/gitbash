modules=`cat .gitmodules | grep "\[submodule" | sed -e s/.*\ \"//g | sed -e s/\"]//g`
for module in $modules; do
	cd $module
	git checkout master
	git pull origin master
	cd ..
done

