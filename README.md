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

### On Linux

- Text Editor: [neovim](https://github.com/neovim/neovim) with [Packer](https://github.com/wbthomason/packer.nvim) plugin manager
- Shell: zsh with oh-my-zsh
- [mise](https://github.com/jdx/mise) for manage Python, Node, Go, pnpm, terraform… installation (formely called "rtx", equivalent of [asdf](https://github.com/asdf-vm/asdf) tool)
- [tmux](https://en.wikipedia.org/wiki/Tmux)
- Docker
- [fzf](https://github.com/junegunn/fzf)
- [ActivityWatch](https://activitywatch.net/) (https://github.com/2e3s/awatcher/ for Wayland + Gnome support)
- [Obsidian](https://obsidian.md/)
- Neovim plugins:
  - Theme: [catppuccin](https://github.com/catppuccin/nvim)
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    - [nvim-ts-rainbow2](https://github.com/HiPhish/nvim-ts-rainbow2/) ([from](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins))
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
    - Custom snippets:
      - [postgres.lua](./dot_config/nvim/lua/snippets/postgres.lua) 
  - [telescope-luasnip.nvim](https://github.com/benfowler/telescope-luasnip.nvim)
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
  - [ActivityWatch/aw-watcher-vim](https://github.com/ActivityWatch/aw-watcher-vim)
  - [obsidian-nvim/obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim)


### On Linux

```
$ neofetch --stdout
stephane@t14s
-------------
OS: Fedora Linux 39 (Workstation Edition) x86_64
Host: 21CQCTO1WW ThinkPad T14s Gen 3
Kernel: 6.6.9-200.fc39.x86_64
Uptime: 3 days, 59 mins
Packages: 3317 (rpm), 54 (flatpak)
Shell: zsh 5.9
Resolution: 3840x2160
DE: GNOME 45.2
WM: Mutter
WM Theme: Adwaita
Theme: Adwaita:dark [GTK2/3]
Icons: Adwaita [GTK2/3]
Terminal: tmux
CPU: AMD Ryzen 7 PRO 6850U with Radeon Graphics (16) @ 4.768GHz
GPU: AMD ATI Radeon 680M
Memory: 25448MiB / 30847MiB
```

My Flatpak app list at 2023-01-08:

```
$ flatpak list --app
Name                                     Application ID                                      Version                         Branch           Origin            Installation
Bitwarden                                com.bitwarden.desktop                               2023.12.1                       stable           flathub           system
Discord                                  com.discordapp.Discord                              0.0.39                          stable           flathub           system
WhatsApp for Linux                       com.github.eneshecan.WhatsAppForLinux               1.6.4                           stable           flathub           system
Flatseal                                 com.github.tchx84.Flatseal                          2.1.0                           stable           flathub           system
Mattermost                               com.mattermost.Desktop                              5.6.0                           stable           flathub           system
Blanket                                  com.rafaelmardojai.Blanket                          0.6.0                           stable           flathub           system
Slack                                    com.slack.Slack                                     4.36.136                        stable           flathub           system
Spotify                                  com.spotify.Client                                  1.2.26.1187.g36b715a1           stable           flathub           system
Visual Studio Code                       com.visualstudio.code                               1.84.2-1699528352               stable           flathub           system
Element                                  im.riot.Riot                                        1.11.53                         stable           flathub           system
Youtube Downloader Plus                  io.github.aandrew_me.ytdn                           3.16.1                          stable           flathub           system
Kooha                                    io.github.seadve.Kooha                              2.2.4                           stable           flathub           system
Obsidian                                 md.obsidian.Obsidian                                1.5.3                           stable           flathub           system
Joplin                                   net.cozic.joplin_desktop                            2.13.12                         stable           flathub           system
Scribus                                  net.scribus.Scribus                                 1.6.0                           stable           flathub           system
Audacity                                 org.audacityteam.Audacity                           2.3.0                           stable           fedora            system
Chromium Web Browser                     org.chromium.Chromium                               120.0.6099.199                  stable           flathub           system
Flatpak External Data Checker            org.flathub.flatpak-external-data-checker                                           stable           flathub           system
Éditeur d’image GIMP                     org.gimp.GIMP                                       2.10.36                         stable           flathub           system
D-Spy                                    org.gnome.dspy                                      44.0                            stable           fedora            system
Inkscape                                 org.inkscape.Inkscape                               1.3.2                           stable           fedora            system
JOSM                                     org.openstreetmap.josm                              18907                           stable           flathub           system
Pitivi                                   org.pitivi.Pitivi                                   2023.03                         stable           flathub           system
Signal Desktop                           org.signal.Signal                                   6.43.1                          stable           flathub           system
Telegram Desktop                         org.telegram.desktop                                4.14.3                          stable           flathub           system
VLC                                      org.videolan.VLC                                    3.0.19                          stable           flathub           system
Zulip                                    org.zulip.Zulip                                     5.10.3                          stable           flathub           system
```

```
$ gnome-extensions list
just-perfection-desktop@just-perfection
gTile@vibou
simple-timer@majortomvr.github.com
thinkpad-battery-threshold@marcosdalvarez.org
freon@UshakovVasilii_Github.yahoo.com
simple-workspaces-bar@null-git
toggle-workspace-span@arngo.github.com
apps-menu@gnome-shell-extensions.gcampax.github.com
background-logo@fedorahosted.org
launch-new-instance@gnome-shell-extensions.gcampax.github.com
places-menu@gnome-shell-extensions.gcampax.github.com
window-list@gnome-shell-extensions.gcampax.github.com
monitor@astraext.github.io
```

### On macOS

- [Karabiner-Elements](https://karabiner-elements.pqrs.org/)

### LibreWolf extensions

See this evergreen note: https://notes.sklein.xyz/extension%20Browser/

## My default directory structure

```
$ mkdir -p ~/git/github/stephane-klein/ # My https://github.com/stephane-klein/ projects
$ mkdir -p ~/vaults/main/               # My default Obsidian vault
```

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
