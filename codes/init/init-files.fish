function init-files
    echo "package_name=" >$resource_dir/ctpm_pkg_info
    echo "package_ver=" >>$resource_dir/ctpm_pkg_info
    echo "package_packager=" >>$resource_dir/ctpm_pkg_info
    echo "package_level=sys/user" >>$resource_dir/ctpm_pkg_info
    echo "package_unis=0/1" >>$resource_dir/ctpm_pkg_info
    touch $resource_dir/src/file_list
    touch $resource_dir/src/unis_hooks
    touch hooks
end
