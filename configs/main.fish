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
        logger 0 "Quicksand@build1"
    case h help '*'
        echo "
(./)app [init, pack] argv[1]

    init: Create a new package

    pack: Pack the package
    
"
end
