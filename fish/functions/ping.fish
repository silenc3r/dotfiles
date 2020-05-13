# Defined in - @ line 1
function ping --description 'alias ping=ping -c 3'
	command ping -c 3 $argv;
end
