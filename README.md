# FOR DORN

My Neovim config. It's built on [LazyVim](https://github.com/LazyVim/LazyVim) but
I've changed a lot of it: my own statusline, a port of the BlackFox theme from Zed,
a 40k-themed start screen, and a setup for the stuff I actually work on (Vue, JS,
SCSS, SQL, plus some Rust and C++).

I came over from Zed with vim mode turned on, so some of the keybinds are there to
keep my muscle memory working. I mostly run it in zellij on WSL, but the bootstrap
script works on macOS and normal Linux too.

![Neovim 0.11+](https://img.shields.io/badge/Neovim-0.11+-57A143?logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/LazyVim-base-2E7DE9)

## Install

You need Neovim 0.11+, git, a C compiler, Node 18+, ripgrep, fd and a
[Nerd Font](https://www.nerdfonts.com/). `bootstrap.sh` installs all of that for you
(works with Homebrew, apt, dnf, pacman and zypper).

```sh
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null   # back up your old config
git clone https://github.com/ejdhindsa/neovim-config.git ~/.config/nvim
~/.config/nvim/bootstrap.sh
```

It's safe to run more than once. If you clone it somewhere other than
`~/.config/nvim`, it backs up whatever's there and symlinks the clone in.

Flags if you want the extras:

| Flag | What it does |
|---|---|
| `--with-rust` | installs rustup |
| `--with-zellij` | installs zellij |
| `--with-claude` | installs the Claude Code CLI |
| `--no-font` | skips downloading JetBrainsMono Nerd Font |
| `--no-bootstrap` | skips installing the plugins at the end |

If you already have everything installed, just clone it and open `nvim`. On Ubuntu,
`fd` is called `fdfind`, so you'll need
`ln -sf "$(command -v fdfind)" ~/.local/bin/fd`.

On the first launch, give Mason a minute or two to install the language servers.
Then run `:Copilot auth`, and `claude` → `/login` if you want the Claude split.
`:checkhealth` will tell you if anything's missing.

## What's in it

Leader is <kbd>Space</kbd>. If you forget a bind, press it and wait for which-key.

### Look

- **BlackFox**: my port of the BlackFox theme from Zed, in `colors/blackfox.lua`.
  I also kept about 20 other themes installed; `<leader>th` previews them live.
- **Statusline**: written from scratch with heirline, in Imperial Fists black and gold.
  It shows the mode, git branch and diff counts, diagnostics, active LSPs, the
  filename and the position in the file.
- **Start screen**: a "FOR DORN" banner with a random Rogal Dorn quote each time.
- bufferline for tabs, noice for the cmdline, incline for floating filenames,
  satellite for the scrollbar, indent-blankline for indent guides and
  tiny-inline-diagnostic for nicer error messages.
- Color swatches next to hex/rgb/hsl values (`<leader>uH`) and a color picker (`<leader>cP`).
  Very handy in SCSS.

### Completion, AI and LSP

- blink.cmp for completion, Copilot for ghost text (`<M-l>` to accept).
- Claude Code in a split on the right with claudecode.nvim (`<leader>ac`). You can
  send it a selection (`<leader>as`) or a file (`<leader>ab`) and accept or reject
  its diffs (`<leader>aa` / `<leader>ay`).
- Language servers through Mason: vtsls, vue_ls, eslint, cssls, jsonls, bashls,
  docker, yamlls, marksman, clangd, rust-analyzer and lua_ls. I limited it to 2
  installs at a time because installing everything at once froze WSL.
- **No format on save.** It kept reformatting code I hadn't touched and made my
  diffs a mess. `<leader>cf` formats by hand, and in visual mode it only formats
  the selection.

### Editing and moving around

| What | Key |
|---|---|
| Jump anywhere (flash) | `s` |
| Harpoon: add file / menu / jump to slot | `<leader>Ha` / `<leader>Hh` / `<leader>1-4` |
| Find files / grep / buffers | `<leader><space>` / `<leader>/` / `<leader>,` |
| Undo tree | `<leader>fu` |
| Symbol outline | `<leader>co` |
| Multi-cursor, Zed style | `<C-n>` |
| Move lines | `<M-h/j/k/l>` |
| Surround | `gsa` / `gsd` / `gsr` |
| Increment numbers, dates, booleans, `let`/`const`, CSS units | `<C-a>` / `<C-x>` |
| Halve indentation of a selection (for `.vue` templates) | `<leader>i2` |
| Project-wide find and replace | `<leader>sr` |
| Command palette | `<leader>fp` |

`w`/`e`/`b` also stop inside camelCase and snake_case words (nvim-spider).

### Files and git

- oil.nvim is my main file manager (`-`). You edit the folder like a text file and
  save to apply the changes. neo-tree is still there as a sidebar (`<leader>e`).
- Inline git blame on the current line, lazygit (`<leader>gg`), diffview
  (`<leader>gdd`), copying a permalink to the current line (`<leader>gy`) and
  merge-conflict helpers (`co`/`ct`/`cb`).

### Work stuff

- Vitest tests from inside the file with neotest (`<leader>tr` / `<leader>tt`).
- Overseer for running `package.json` scripts and VS Code tasks (`<leader>or`).
- package-info shows outdated npm versions right in `package.json` (`<leader>ns`).
- A SQL client through dadbod-ui (`<leader>Du`). The connections come from the
  `DBUI_STORE` and `DBUI_CORP` env vars, so no passwords are in the repo. In SQL
  files `<leader>s` runs the query.

### Small things

- Saves all modified files every minute.
- Reloads files that change on disk. I added this because when Claude edited
  something in another zellij pane, Neovim never noticed.
- `<C-h/j/k/l>` moves between splits and keeps going into zellij panes.
- On WSL, copy/paste goes through win32yank if you have it, otherwise OSC52 and
  PowerShell.
- Discord status through presence.nvim. It never shows what file or project I
  have open, just a 40k joke that changes every 30 minutes.
- Zen mode (`<leader>uz`) and WakaTime.

There's a much longer write-up of every plugin in [neovim-setup.md](neovim-setup.md).

## zellij

`<C-h/j/k/l>` works out of the box from inside Neovim. If you also want it to work
from the other zellij panes, install
[zellij-autolock](https://github.com/fresh2dev/zellij-autolock) and add this to
`~/.config/zellij/config.kdl`:

```kdl
keybinds {
    shared_except "locked" {
        bind "Ctrl h" { MoveFocusOrTab "Left"; }
        bind "Ctrl j" { MoveFocus "Down"; }
        bind "Ctrl k" { MoveFocus "Up"; }
        bind "Ctrl l" { MoveFocusOrTab "Right"; }
    }
}
```

Only add these with autolock installed. Otherwise zellij grabs the keys before
Neovim ever sees them.

## Layout

```
├── init.lua
├── bootstrap.sh
├── neovim-setup.md
├── colors/blackfox.lua
├── lua/config/     options, keymaps, autocmds, lazy.nvim setup
└── lua/plugins/    one file per area (ui, git, lang, motion, ...)
```

The LazyVim extras I use are in `lua/config/lazy.lua`.

## Credits

[LazyVim](https://github.com/LazyVim/LazyVim) for the base, Matej Cerny for the
original BlackFox theme, and all the plugin authors listed in
[neovim-setup.md](neovim-setup.md).
