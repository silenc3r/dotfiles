# Defined in /tmp/fish.euSsPK/lns.fish @ line 1
function lns --description 'Symlink with absolute path'
	ln -s (realpath $argv[1]) $argv[2]
end
