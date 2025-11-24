# Authentication failed. Some common reasons include
```sh
git credential-osxkeychain erase
# when prompted, enter:
# host=github.com
# protocol=https
# [empty line to submit]
```

```
ssh -vT git@github.com
# should see Hi <USER>! You've successfully authenticated, but GitHub does not provide shell access.
```

```
# Create a key (if you don’t have one)
ssh-keygen -t ed25519 -C "you@example.com"

# Start agent & add key
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Save agent use in ~/.ssh/config (create if missing)
cat <<'EOF' >> ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  UseKeychain yes
EOF

# Copy public key and add it at GitHub → Settings → SSH and GPG keys
pbcopy < ~/.ssh/id_ed25519.pub
```
