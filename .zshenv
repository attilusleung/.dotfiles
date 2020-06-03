if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
export PATH=~/.cargo/bin:~/.local/bin:$PATH
