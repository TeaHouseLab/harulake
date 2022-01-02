function init-files
    echo "package_name=" >$resource_dir/ctpm_pkg_info
    echo "package_ver=" >>$resource_dir/ctpm_pkg_info
    echo "package_level=" >>$resource_dir/ctpm_pkg_info
    touch $resource_dir/src/file_list
end
