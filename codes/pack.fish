function pack
    set -lx resource_dir $argv[1]
    if [ "$argv[1]" = "" ]
        set resource_dir .
    end
    set package_level (sed -n '/package_level=/'p $resource_dir/ctpm_pkg_info | sed 's/package_level=//g')
    set package_name (sed -n '/package_name=/'p $resource_dir/ctpm_pkg_info | sed 's/package_name=//g')
    set package_ver (sed -n '/package_ver=/'p $resource_dir/ctpm_pkg_info | sed 's/package_ver=//g')
    set package_unis (sed -n '/package_unis=/'p $resource_dir/ctpm_pkg_info | sed 's/package_unis=//g')
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
    if test -d $resource_dir/src
        if test -e $resource_dir/src/file_list
            for src_file in (cat $resource_dir/src/file_list)
            end
            if test -e $resource_dir/src$src_file
            else
                logger 4 "$src_file doesn't exist in $resource_dir/src,but you declared it in file_list,abort"
                exit
            end
        else
            logger 4 "No $resource_dir/src/file_list defined,abort"
            exit
        end
    else
        logger 4 'No src directory,abort'
    end
    logger 0 "Packing $package_name.ctpkg"
    tar zcf $package_name.ctpkg $resource_dir/ &>/dev/null
    logger 0 "Processed,store at $package_name.ctpkg"
end
