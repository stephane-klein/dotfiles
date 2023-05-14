## stephane-klein dotfiles powered by Chezmoi

Status: I use this configuration daily since about September 2022.

See my initial issue: https://github.com/stephane-klein/personnal-notebook/issues/25 (in French)

These dotfiles are managed using [chezmoi](https://www.chezmoi.io/).

Concerning Neovim, I am considering a migration to [LazyVim](https://www.lazyvim.org/) (more info, see [#98](https://github.com/stephane-klein/dotfiles/issues/98)).

So far, only GNU/Linux Fedora 38 is supported.

Upon fresh installation, the [run_once_install-fedora-packages.sh.tmpl](./run_once_install-fedora-packages.sh.tmpl) (idempotent and POSIX compliant) script would be executed once.

## What I use

Since March 2023, I use exclusively Fedora on Thinkpad T14s Gen3 AMD.  
I don't use MacOS anymore.

### On Linux and macOS

- Text Editor: [neovim](https://github.com/neovim/neovim) with [Packer](https://github.com/wbthomason/packer.nvim) plugin manager
- Shell: zsh with oh-my-zsh
- [asdf](https://github.com/asdf-vm/asdf) for manage Python, Node, Go, pnpm, terraform… installation
- [tmux](https://en.wikipedia.org/wiki/Tmux)
- Docker
- [fzf](https://github.com/junegunn/fzf)
- Neovim plugins:
  - Theme: [catppuccin](https://github.com/catppuccin/nvim)
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
  - [Neoformat](https://github.com/sbdchd/neoformat)
  - [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)

### On Linux

- OS: Fedora 38
- Gnome extensions:
  - [A dock for the COSMIC/GNOME Shell, fixes conflict with COSMIC Workspaces](https://github.com/halfmexican/dash-to-dock-pop/tree/ubuntu-dock)
  - [NoAnnoyance v2 GNOME Shell Extension](https://github.com/bdaase/noannoyance)
  - [gTile - Gnome-shell extension that improves window tiling capabilities of stock gnome-shell](https://github.com/gTile/gTile)
  - [WindowIsReady_Remover](https://github.com/nunofarruca/WindowIsReady_Remover)

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
  - I use this [Disable GitLab, GitHub Emoji Picker](https://userstyles.org/styles/244590/disable-gitlab-github-emoji-picker) userstyle
- https://addons.mozilla.org/fr/firefox/addon/tab-counter-webext/
- https://addons.mozilla.org/fr/firefox/addon/tournesol-extension/
- https://addons.mozilla.org/fr/firefox/addon/ublock-origin/
- https://addons.mozilla.org/fr/firefox/addon/video-downloadhelper/
- https://github.com/gdh1995/vimium-c ([here is](vimium_c.json) my config that I can import)
- https://addons.mozilla.org/fr/firefox/addon/wappalyzer/
- https://addons.mozilla.org/fr/firefox/addon/view-page-archive/
- https://addons.mozilla.org/en-US/firefox/addon/always-open-in-current-tab/
- https://markdown-here.com/ (I use it to write email with Fastmail and Gmail)

Firefox Theme: https://github.com/elibroftw/matte-black-theme/releases

## Backup

As of May 12, 2023, I start using https://www.backblaze.com/ B2 Cloud Storage to backup some data, with restic.

Some ressources:

Documentation: https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#backblaze-b2

See parameter in Bitwarden.

```
$ export B2_ACCOUNT_ID=xxx
$ export B2_ACCOUNT_KEY=xxxx
$ export RESTIC_PASSWORD="xxxx"
```

```
$ restic version
restic 0.15.2 compiled with go1.20.3 on darwin/amd64
$ restic -r b2:backup-eu-santa-maria-2021: init
$ restic -r b2:backup-eu-santa-maria-2021 backup __folder__
$ restic -r b2:backup-eu-santa-maria-2021 snapshots
$ restic -r b2:backup-eu-santa-maria-2021 restore __id__ --target ./
```

## Getting started

### Install chezmoi and the dotfiles on any new machine

With a single command:

```sh
$ sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply stephane-klein
```

## Hardware devices

### Lenovo Thinkpad T14s Gen3 AMD (personnal)

 ThinkPad T14s Gen 3 ([Notebookcheck review](https://www.notebookcheck.net/Lenovo-ThinkPad-T14s-G3-AMD-laptop-review-Quiet-and-efficient-workhorse-with-Ryzen-power.682906.0.html))

- Processeur AMD Ryzen™ 7 Pro 6850U (2,70 GHz - 4,70 GHz)
- 32Go RAM
- 512 SSD
- 14" WUXGA (1 920 x 1 200), IPS, anti-reflets, non tactile, 72 % NTSC, 400 nits 
- 1,22 kg
- [« Battery life was great with Linux on the T14s. I was getting somewhere near 18 hours »](https://old.reddit.com/r/thinkpad/comments/z2mxfm/appreciate_help_deciding_between_t14_gen_3_amd/ixh6jnp/)
- 1740 € HT (France 2023-01-30)
- [`inxi -F`](https://github.com/smxi/inxi) specification output: [inxi_2023-03-26.txt ](https://gist.github.com/stephane-klein/0735abce4359b705f85ce1502d214ba3)
- [edid-decode output](https://discussion.fedoraproject.org/t/regalar-screen-glitch-on-thinkpad-t14s-gen3-amd/79963/4)
- `dmidecode -s bios-version` : `R22ET55W (1.25 )`


## Neovim ressources

Here is my source of inspiration to find Neovim plugin and configuration settings:

- https://www.reddit.com/r/neovim/
- https://neovimcraft.com/
- https://vimawesome.com/
- https://github.com/WhoIsSethDaniel/dotfiles/ (configuration 100% based on Lua)
  - https://www.sethdaniel.dev/vim/plugins/
- https://github.com/topics/dotfiles
