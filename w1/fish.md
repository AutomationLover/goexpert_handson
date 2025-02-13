guide to installing the Fish shell and setting up useful plugins on macOS:
1. Install Fish Shell
Using Homebrew (Recommended):
Open your terminal and run:
```bash
brew install fish
```

2. Add Fish to the list of valid login shells:
```bash
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
```

3. Make Fish your default shell:
```bash
chsh -s /opt/homebrew/bin/fish
```

4. Restart your terminal to start using Fish.
