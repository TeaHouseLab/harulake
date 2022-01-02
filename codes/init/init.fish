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
