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
        logger 4 'No package_name defined,abort'
        exit
    end
    if [ "$package_ver" = "" ]
        logger 4 'No package_ver defined,abort'
        exit
    end
    if [ "$package_level" = "" ]
        logger 4 'No package_level defined,abort'
        exit
    end
    if test -d src
        if test -e src/file_list
            for src_file in (cat src/file_list)
                if test -e src$src_file
                else
                    logger 4 "$src_file doesn't exist in src,but you declared it in file_list,abort"
                    exit
                end
            end
        else
            logger 4 "No src/file_list defined,abort"
            exit
        end
    else
        logger 4 'No src directory,abort'
    end
    logger 0 "Packing $package_name.ctpkg"
    tar zcf $package_name.ctpkg . &>/dev/null
    mv $package_name.ctpkg $recudir &>/dev/null
    cd $recudir
    logger 0 "Processed,store at $recudir/$package_name.ctpkg"
end
