function pack
    set -lx resource_dir $argv[1]
    set -lx recudir (pwd)
    if [ "$argv[1]" = "" ]
        set resource_dir .
    end
    cd $resource_dir
    set package_level (sed -n '/package_level=/'p ctpm_pkg_info | sed 's/package_level=//g')
    set package_name (sed -n '/package_name=/'p ctpm_pkg_info | sed 's/package_name=//g')
    set package_ver (sed -n '/package_ver=/'p ctpm_pkg_info | sed 's/package_ver=//g')
    set package_unis (sed -n '/package_unis=/'p ctpm_pkg_info | sed 's/package_unis=//g')
    if [ "$package_name" = "" ]
        logger 5 'No package_name defined,abort'
        exit
    end
    if [ "$package_ver" = "" ]
        logger 5 'No package_ver defined,abort'
        exit
    end
    if [ "$package_level" = "" ]
        logger 5 'No package_level defined,abort'
        exit
    end
    if test -x prehook
        set prehook true
        logger 0 "Running prehook before packing..."
        if ./prehook
            logger 2 "Prehook succeed"
        else
            logger 5 "Failed to run prehook, abort"
            exit
        end
    end
    if test -d src
        if test -e src/file_list
            for src_file in (cat src/file_list)
                if test -e src$src_file
                else
                    logger 5 "$src_file doesn't exist in src,but you declared it in file_list,abort"
                    exit
                end
            end
        else
            logger 5 "No src/file_list defined,abort"
            exit
        end
    else
        logger 5 'No src directory,abort'
    end
    logger 0 "Packing $package_name.ctpkg"
    if test "$prehook" = true
        tar zcf $package_name.ctpkg . &>/dev/null
    else
        tar --exclude='./prehook' zcf $package_name.ctpkg . &>/dev/null
    end
    mv $package_name.ctpkg $recudir &>/dev/null
    cd $recudir
    logger 1 "Processed,store at $recudir/$package_name.ctpkg"
end
