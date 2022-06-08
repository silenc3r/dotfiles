function pbpaste --wraps='xclip -selection c -o' --description 'alias pbpaste xclip -selection c -o'
  xclip -selection c -o $argv; 
end
