def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

#######################
## Color definitions ##
#######################

# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

def yellow(text);   colorize(text, '4;33'); end
def title(text); colorize(text, '44'); end