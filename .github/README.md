# My AstroNvim User Configuration

A user configuration for [AstroNvim](https://github.com/AstroNvim/AstroNvim).

## 🛠️ Installation

#### Install Neovim

If you haven't already install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim).

#### Make a backup of your current nvim and shared folder (Optional)

If you have made any modifications to your config you might want to back up your config since this
process will overwrite your existing config.

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Download config and install plugins

First, you need to download the base AstroNvim configuration, and then add this repo as the `user`
directory within the AstroNvim config. The last command dry-runs Neovim to install the plugins and
quit. You might need to run this command more than once, until the command no longer prints any
output. That is optional though, since if you open Neovim normally, it will still install the
necessary plugins, but you will probably need to close and open it to work properly.

```shell
# Clone AstroNvim config
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# Clone this repository as user config
git clone https://github.com/menoua/astronvim_config ~/.config/nvim/lua/user
# Initialize AstroNvim to install plugins
nvim  --headless -c 'quitall'
```

#### Usage

```shell
# Start Neovim
nvim
```
