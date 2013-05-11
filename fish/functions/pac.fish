function pac
    switch $argv[1]
        case '-D' '-R*' '-U*' '-S' '-Sc*' '-Sd*' '-Su*' '-Sw*' '-Sy*'
            /usr/bin/sudo /usr/bin/pacman $argv
            return 0
        case '*'
            /usr/bin/pacman $argv
            return 0
    end
end
