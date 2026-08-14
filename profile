if command -v keychain >/dev/null 2>&1; then
    eval "$(keychain --eval --agents ssh ~/.ssh/id_ed25519)"
else
    echo "Skipping unlocking keys, no keychain command"
fi


# Load rust/Cargo development environment
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Load terminal config
[ -f ~/.bashrc ] && . ~/.bashrc

