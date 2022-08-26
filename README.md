## stephane-klein dotfiles powered by Chezmoi

Status: work in progress, pre-alpha

See my initial issue: https://github.com/stephane-klein/personnal-notebook/issues/25 (in French)

These dotfiles are managed using [chezmoi](https://www.chezmoi.io/).

So far, only GNU/Linux Fedora is supported.

Upon fresh installation, the [run_once_install-fedora-packages.sh.tmpl](./run_once_install-fedora-packages.sh.tmpl) (idempotent and POSIX compliant) script would be executed once.

## What I use  

### On Linux and macOS

- Text Editor: [neovim](https://github.com/neovim/neovim) with [Packer](https://github.com/wbthomason/packer.nvim) plugin manager
- Shell: zsh with oh-my-zsh
- [asdf](https://github.com/asdf-vm/asdf) for manage Python, Node, Go, pnpm, terraform… installation
- [tmux](https://en.wikipedia.org/wiki/Tmux)
- Docker
- [fzf](https://github.com/junegunn/fzf)
- Neovim plugins:
  - Theme: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    - [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow/)
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    - [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
  - [mason.nvim](https://github.com/williamboman/mason.nvim)
  - [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker)
  - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
  - [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
  - [nvim-comment](https://github.com/terrortylor/nvim-comment)
  - [leap](https://github.com/ggandor/leap.nvim)
  - [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
  - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
    - [cmp-path](https://github.com/hrsh7th/cmp-path)
    - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
  - [vim-matchup](https://github.com/andymass/vim-matchup)
  - [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
  - [vim-sandwich](https://github.com/nvim-lualine/machakann/vim-sandwich)
  - [vim-fugitive](https://github.com/tpope/vim-fugitive)
  - [fugitive-gitlab.vim](https://github.com/shumphrey/fugitive-gitlab.vim)
  - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
  - [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)
  - [vim-cutlass](https://github.com/svermeulen/vim-cutlass)
  - [vim-yoink](https://github.com/svermeulen/vim-yoink)
  - [alpha-nvim](https://github.com/goolord/alpha-nvim/)
  - [focus.nvim](https://github.com/beauwilliams/focus.nvim)
  - [NeoZoom.lua](https://github.com/nyngwang/NeoZoom.lua/tree/neo-zoom-original)
  - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
    - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
  - [true-zen.nvim](https://github.com/Pocco81/true-zen.nvim)
  - [neoclip](https://github.com/matveyt/neoclip) (to fix Wayland bug)
  - [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
  - [toggletasks.nvim](https://github.com/jedrzejboczar/toggletasks.nvim)
  - [emmet-vim](https://github.com/mattn/emmet-vim)
  - [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
    - [eslint](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#eslint) enabled
    - [prettierd](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#prettierd)
  - [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

### On Linux

- OS: Fedora 36
- Gnome extensions:
  - [AATWS - Advanced Alt-Tab Window Switcher](https://github.com/G-dH/advanced-alttab-window-switcher)
  - [Emoji Selector (for GNOME Shell)](https://github.com/maoschanz/emoji-selector-for-gnome)
  - [gTile](https://github.com/gTile/gTile) (in practice, I don't use this extension very often)
  - [Time ++](https://github.com/zagortenay333/timepp) (See https://github.com/stephane-klein/dotfiles/issues/38)
  - [Hot Edge](https://github.com/jdoda/hotedge) (I replaced [Dash to Dock for Pop!_OS](https://github.com/halfmexican/dash-to-dock-pop/tree/ubuntu-dock) by [Hot Edge](https://github.com/jdoda/hotedge) since 2022-08-19)

### On macOS

- [Karabiner-Elements](https://karabiner-elements.pqrs.org/)


### Firefox extensions

- https://github.com/fabiocchetti/wide-github/
- https://addons.mozilla.org/fr/firefox/addon/close-all-button/
- https://addons.mozilla.org/fr/firefox/addon/languagetool/
- https://darkreader.org/
- https://duckduckgo.com/app
- https://github.com/mozilla/multi-account-containers
- https://addons.mozilla.org/fr/firefox/addon/hnes/
- https://addons.mozilla.org/fr/firefox/addon/hohser/
- https://addons.mozilla.org/fr/firefox/addon/joplin-web-clipper/
- https://addons.mozilla.org/fr/firefox/addon/old-reddit-redirect/
- https://addons.mozilla.org/fr/firefox/addon/reddit-enhancement-suite/
- https://addons.mozilla.org/fr/firefox/addon/sponsorblock/
- https://addons.mozilla.org/fr/firefox/addon/styl-us/
- https://addons.mozilla.org/fr/firefox/addon/tab-counter-webext/
- https://addons.mozilla.org/fr/firefox/addon/tournesol-extension/
- https://addons.mozilla.org/fr/firefox/addon/ublock-origin/
- https://addons.mozilla.org/fr/firefox/addon/video-downloadhelper/
- https://addons.mozilla.org/fr/firefox/addon/vimium-ff/
- https://addons.mozilla.org/fr/firefox/addon/wappalyzer/
- https://addons.mozilla.org/fr/firefox/addon/view-page-archive/


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
  - https://www.sethdaniel.dev/vim/plugins/
- https://github.com/topics/dotfiles
