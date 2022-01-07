#!/usr/bin/env fish

#!/usr/bin/env fish
function logger-warn
  set_color magenta
  echo "$prefix [Warn] $argv[1..-1]"
  set_color normal
end
function logger-error
  set_color red
  echo "$prefix [Error] $argv[1..-1]"
  set_color normal
end
function logger-info
  set_color normal
  echo "$prefix [Info] $argv[1..-1]"
  set_color normal
end
function logger-debug
  set_color yellow
  echo "$prefix [Debug] $argv[1..-1]"
  set_color normal
end
function logger-success
  set_color green
  echo "$prefix [Successed] $argv[1..-1]"
  set_color normal
end
function logger -d "a lib to print msg quickly"
switch $argv[1]
case 0
  logger-info $argv[2..-1]
case 1
  logger-success $argv[2..-1]
case 2
  logger-debug $argv[2..-1]
case 3
  logger-warn $argv[2..-1]
case 4
  logger-error $argv[2..-1]
end
end

function install
set installname $argv[1]
  set dir (realpath (dirname (status -f)))
  set filename (status --current-filename)
  chmod +x $dir/$filename
  sudo cp $dir/$filename /usr/bin/$installname
  set_color green
  echo "$prefix Installed"
  set_color normal
end
function uninstall
set installname $argv[1]
  sudo rm /usr/bin/$installname
  set_color green
  echo "$prefix Removed"
  set_color normal
end

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
    tar zcf $package_name.ctpkg $resource_dir/
    logger 0 "Processed,store at $package_name.ctpkg"
end

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

function init
    set -lx resource_dir $argv[1]
    if [ "$argv[1]" = "" ]
        set resource_dir .
    end
    mkdir -p $resource_dir/src
    init-files
    echo "$prefix Deployed"
    set_color normal
end

echo Build_Time_UTC=2022-01-07_13:49:17
set -lx prefix [harulake]
switch $argv[1]
    case init
        init $argv[2]
    case pack
        pack $argv[2]
    case install
        install harulake
    case uninstall
        uninstall harulake
    case v V
        logger 0 "harulake.FrostFlower@build2"
    case h help *
        logger 0 "init argv >>> make a new package
pack argv >>> pack the package"
end
