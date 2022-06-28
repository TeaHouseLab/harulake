function init
    set -lx resource_dir $argv[1]
    if [ "$argv[1]" = "" ]
        set resource_dir .
    end
    logger 0 "Start deploying package source..."
    mkdir -p $resource_dir/src
    init-files
    logger 1 "Deployed"
    set_color normal
end
