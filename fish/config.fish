alias gs="git status"
alias tmat="tmux attach -t"
alias tren="tmux rename-session -t"
alias tls="tmux ls"
alias tekila="tmux kill-session -t"
alias vodka="tmux kill-server"
alias res="git restore ."
alias sync-master="git pull origin master"
alias ga="git add ."
alias gmit="git commit -m"
alias push="git push"
alias log="git lg"
alias out="git checkout"
alias pull="git pull"
alias python="python3"
alias br="git branch"
alias brr="git branch -r"
alias bra="git branch --all"
alias skhdconfig="nvim ~/.config/skhd/skhdrc"
alias yabaiconfig="nvim ~/.yabairc"
alias fishconfig="nvim ~/.config/fish/config.fish"
alias nr="npm run"
alias resyabai="brew services restart yabai"
alias vim="nvim"
alias vimconfig="nvim ~/.config/nvim/init.vim"
alias lg="lazygit"
alias save="git add . && git commit -m "
alias source_fish="source ~/.config/fish/config.fish"
alias nv="/Users/sohail.haqyar/Applications/neovide.app/Contents/MacOS/neovide --frame=none --multigrid"
alias tm="tmuxifier"
alias ranger="pipx run --spec ranger-fm ranger"
alias mux="tmuxinator"
 



if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
fish_vi_key_bindings
bind -M insert \cf accept-autosuggestion



function gasp
    git add .
    git commit -m $argv
    git push
end



function salient-out
    git checkout -b "jira/CLD-$argv"
end

 

function glco
   git checkout $(git branch | fzf | sed 's/origin//'| cut -c 3-)
end

# same as above but for remote branches
function grco
   git checkout $(git branch -r | fzf | sed 's/origin//'| cut -c 4-)
end



# function that takes a branch name as first argument and optionally takes a --remote flag as second argument
# if --remote flag is present it will run the grco function

function gc
   if set -q argv[1]
        if test $argv[1] = "--remote"
            grco
        end
    else
        glco 
    end 
end


function get-remote-branch
    git branch -r | fzf | sed 's/origin//'| sed 's/remotes//' | cut -c 4-
end

function get-local-branch
    git branch | fzf | sed 's/origin//'| cut -c 3-
end

function gb 
  if set -q argv[1]
        if test $argv[1] = "-r"
            get-remote-branch
        end
    else
        get-local-branch
    end
end


function grb
	git checkout (git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | egrep -v '^[a-f0-9]{40}$' | head -n$argv | fzf)
end

function gls 
	git branch --all | grep $argv 
end

function out-ago 
	rc-br $argv | tail -1
end



function find-br 
   if set -q argv[2]
        if test $argv[2] = "--remote"
            git branch -r | grep $argv[1] | tail -1 | sed 's/origin//'| cut -c 4-
        end
    else
        git branch | grep $argv[1] | tail -1 | sed 's/origin//'| cut -c 3-
    end 
end


set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $HOME/.cargo/bin
set -gx PATH /opt/homebrew/lib/ruby/gems/2.7.0/bin $PATH
set -gx PATH /usr/local/lib/ruby/gems/2.7.0/bin $PATH
set -gx PATH $PATH ~/development/flutter/bin
set -gx PATH $PATH $HOME/.pub-cache/bin
set -x LUNARVIM_RUNTIME_DIR $HOME/.config/nvim
set -x PATH $PATH $HOME/.emacs.d/bin
set -x PATH $PATH /opt/local/bin
set -gx PATH $PATH $HOME/.tmuxifier/bin
set -gx EDITOR $EDITOR /opt/homebrew/bin/nvim


eval (tmuxifier init - fish)
