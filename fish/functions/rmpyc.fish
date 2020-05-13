# Defined in /tmp/fish.jVTPm8/rmpyc.fish @ line 2
function rmpyc --description 'Remove cached python files'
	find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete;
end
