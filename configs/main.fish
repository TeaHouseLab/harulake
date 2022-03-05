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
        logger 0 "Corleone@build1"
    case h help *
        logger 0 "init argv >>> make a new package
pack argv >>> pack the package"
end
