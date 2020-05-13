# Defined in - @ line 1
function dnf --description 'alias dnf=dnf --cacheonly'
	command dnf --cacheonly $argv;
end
