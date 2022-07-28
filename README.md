## stephane-klein dotfiles powered by Chezmoi

Status: work in progress, pre-alpha

See my initial issue: https://github.com/stephane-klein/personnal-notebook/issues/25 (in French)

These dotfiles are managed using [chezmoi](https://www.chezmoi.io/).

So far, only GNU/Linux Fedora is supported.

Upon fresh installation, the [run_once_install-fedora-packages.sh.tmpl](./run_once_install-fedora-packages.sh.tmpl) (idempotent and POSIX compliant) script would be executed once.

## What I use  

- OS: Fedora 36
- Text Editor: [neovim](https://github.com/neovim/neovim) with [Packer](https://github.com/wbthomason/packer.nvim) plugin manager
- Shell: zsh with oh-my-zsh
- [asdf](https://github.com/asdf-vm/asdf) for manage Python, Node, Go, pnpm, terraform… installation
- Docker
- [fzf](https://github.com/junegunn/fzf)
- Neovim plugins:
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
  - [mason.nvim](https://github.com/williamboman/mason.nvim)
  - [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker)
  - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
  - [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
  - [nvim-comment](https://github.com/terrortylor/nvim-comment)
  - [leap](https://github.com/ggandor/leap.nvim)

## Getting started

### Install chezmoi and the dotfiles on any new machine

With a single command:

```sh
$ sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply stephane-klein
```

## Neovim configuration development workflow

I don't want to update `~/.config/nvim/` directly, before update my config, I test new configuration in
`~/.config-trial/nvim`. I can commit / push the content of this folder.  
If all works perfectly, I merge `~/.config-trial/nvim` to `~/.config/nvim` which is my "stable" Neovim configuration.

## Neovim ressources

Here is my source of inspiration to find Neovim plugin and configuration settings:

- https://www.reddit.com/r/neovim/
- https://neovimcraft.com/
- https://vimawesome.com/
- https://github.com/WhoIsSethDaniel/dotfiles/ (configuration 100% based on Lua)
- https://github.com/topics/dotfiles
