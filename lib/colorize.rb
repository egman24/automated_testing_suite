def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

#######################
## Color definitions ##
#######################

# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

def            time(text);   colorize(text, '4;33'); end
def         feature(text);   colorize(text, '1;37'); end
def          action(text);   colorize(text, '0'); end
def         attempt(text);   colorize(text, '33'); end
def attempt_success(text);   colorize(text, '32'); end
def    attempt_fail(text);   colorize(text, '31'); end
def         browser(text);   colorize(text, '30;47'); end
def blue_background(text);   colorize(text, '44'); end

def title(text, color)

 color_list = { :black_blue   => '30;44',
                :black_purple => '30;45',
                :black_gold   => '30;43',
                :black_red    => '30;41',
                :black_teal   => '30;46'}

  colorize(text, color_list[color])
end
