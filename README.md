# upgraded-dotfiles

### Initial setup
1. Download and install [iTerm2](https://www.iterm2.com).

2. Use the iTerm2 preferences found in the repository. 

   ```
   iTerm2 > Preferences... > Load preferences from a custom folder or URL: /path/to/repo/iTerm2/
   ```

3. Open iTerm2 and execute

   ```
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   ```
   
   to install [Homebrew](https://brew.sh).

4. Use homebrew to install [Zsh](http://www.zsh.org) and [neovim](https://github.com/neovim/neovim).

   ```
   brew install zsh
   brew install neovim
   ```

5. Make iTerm2 launch with Zsh:
   1. Locate the brewed Zsh using `which zsh`
   2. `chsh -s /path/to/zsh`
   
6. Create symbolic links to configuration files in the repository. 

   ```
   ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
   ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
   ```
