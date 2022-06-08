function pbcopy --wraps='xclip -selection c' --description 'alias pbcopy xclip -selection c'
  xclip -selection c $argv; 
end
