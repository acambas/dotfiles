# Intro

This folder contains my dotfiles

# Stow

I'm using stow to create symlinks for my config files
In order to set it up you need to:

- install it using brew `brew install stow`
- cd into the dotfiles
- run `stow .`

# macos settings

in order to setup the macos settings you need to run

```bash
chmod +x ~/.macos
~/.macos
```

# Brew tools for installing

All are in a file called Brewfile
in order to install them all you need to run

```bash
brew bundle
```

extra details https://medium.com/@satorusasozaki/automate-mac-os-x-configuration-by-using-brewfile-58a78ce5cc53

# Extra tools that i install manually

- ohmyzsh: for better shell integration [link](https://ohmyz.sh/)
- live http server [link](https://github.com/tapio/live-server)
- nvm [link](https://github.com/nvm-sh/nvm)

# Secrets

in order to load env variables you need to create a file called .secrets.sh in the root of the repo

example:

```bash
export GITHUB_TOKEN=123
```

# tmux

in order to setup tmux sessionizer you need to run

```bash
chmod +x ~/tmux-sessionizer

```
