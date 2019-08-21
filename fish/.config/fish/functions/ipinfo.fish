# Defined in - @ line 1
function ipinfo --description 'alias ipinfo=curl ipinfo.io/ip'
	curl ipinfo.io/ip $argv;
end
