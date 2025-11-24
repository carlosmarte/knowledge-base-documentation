mkdir -p $HOME/.homebrew

git clone https://github.com/Homebrew/brew $HOME/.homebrew

echo 'export PATH="$HOME/.homebrew/bin:$PATH"' >> ~/.zshrc

source ~/.zshrc

brew --version

brew update
