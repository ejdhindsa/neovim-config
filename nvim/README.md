# Neovim config (LazyVim base)

A personal, heavily-customized Neovim setup built on **LazyVim** as scaffolding.
Runs inside WSL (Ubuntu) in a zellij pane. Migrated from Zed + vim-motions.

> **Theme note:** the active colorscheme is a placeholder (`tokyonight-night`)
> until **BlackFox** (your Zed theme) is ported — see [BlackFox](#blackfox-theme-pending).

---

## 1. Prerequisites (one-time, in WSL)

```sh
# Neovim 0.11.x + unzip (Mason needs unzip for a few servers)
sudo apt update && sudo apt install -y neovim unzip

# 'fd' is packaged as 'fdfind' on Ubuntu — give Telescope/Snacks the name they expect
mkdir -p ~/.local/bin && ln -sf "$(command -v fdfind)" ~/.local/bin/fd
# (ensure ~/.local/bin is on PATH in ~/.zshrc)

# RECOMMENDED for clean clipboard: win32yank (two-way, no CRLF junk)
#   download win32yank.exe and put it on your WSL PATH, e.g. ~/.local/bin/
#   https://github.com/equalsraf/win32yank/releases
```

Already present on your box: `git, node 24, npm, ripgrep, gcc/g++/make, cargo/rustc,
lazygit, zellij, claude` — so LSPs, Treesitter parsers, Rust/C++ all work out of the box.

**A Nerd Font is required** for icons/statusline glyphs. Install one on *Windows*
(e.g. JetBrainsMono Nerd Font or FiraCode Nerd Font) and select it in your terminal
(WezTerm/Windows Terminal).

## 2. First launch

```sh
nvim
```

LazyVim bootstraps `lazy.nvim`, installs every plugin, compiles Treesitter parsers,
and Mason installs the LSP servers. Then:

- `:Copilot auth` — authenticate Copilot ghost-text (one-time).
- `claude` (in a terminal) → `/login` if the CLI isn't already authenticated.
- `:checkhealth` — confirm everything is green.
- `:Lazy` — plugin manager UI. `:Mason` — LSP/tool installer UI.

## 3. Layout

```
~/.config/nvim → ~/dotfiles/nvim   (symlink)
├── init.lua
├── lua/config/        # lazy bootstrap, options, keymaps, autocmds
├── lua/plugins/       # one file per concern (see below)
│   ├── colorscheme.lua   themes + <leader>th picker + BlackFox slot
│   ├── heirline.lua      custom Imperial-Fists statusline
│   ├── ui.lua            bufferline, noice, dashboard, indent, incline, satellite, diag, fidget
│   ├── snacks.lua        QOL toggles (lazygit, scratch, notifier, input…)
│   ├── editing.lua       autopairs, ts-autotag, mini.move, dial, spider, sleuth
│   ├── multicursor.lua   vim-visual-multi
│   ├── motion.lua        flash, (leap opt), harpoon, aerial, marks
│   ├── telescope.lua     undo history (+ picker backend from extra)
│   ├── files.lua         oil (primary) + neo-tree (sidebar)
│   ├── git.lua           gitsigns blame, diffview, gitlinker, git-conflict
│   ├── coding.lua        copilot ghost-text + blink tweaks
│   ├── claude.lua        claudecode.nvim (subscription CLI)
│   ├── color-tools.lua   nvim-highlight-colors + ccc picker
│   ├── lang.lua          treesitter parsers, package-info, dadbod MySQL, markdown
│   ├── testing.lua       neotest + vitest
│   ├── tasks.lua         overseer
│   ├── terminal.lua      zellij-nav, smart-splits, toggleterm
│   ├── workflow.lua      which-key groups, legendary, grug-far, project
│   └── fun.lua           zen, twilight, mini.animate, presence, wakatime
├── lazy-lock.json     # committed for reproducible versions
└── stylua.toml
```

**LazyVim extras** are enabled in `lua/config/lazy.lua` (not via `:LazyExtras`):
telescope, mini-surround, yanky, copilot, neotest, prettier, and langs
(vue, json, docker, markdown, rust, clangd, sql).

## 4. Keymap cheat-sheet (leader = `<Space>`)

### Zed-parity (LazyVim defaults)
| Key | Action |
|---|---|
| `<leader><space>` / `<leader>ff` | Find files (Zed Cmd+P) |
| `<leader>/` / `<leader>sg` | Live grep (Zed Cmd+Shift+F) |
| `<leader>,` | Switch buffers |
| `<leader>e` | Neo-tree sidebar |
| `s` / `S` | Flash jump |
| `gd` `gr` `K` `<leader>ca` `<leader>cr` | LSP: def / refs / hover / action / rename |
| `<leader>cf` | Format (Prettier) |
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>qs` / `<leader>ql` | Restore / load session |

### Custom (added by this config)
| Key | Action |
|---|---|
| `-` / `<leader>-` | oil (parent dir / float) |
| `<leader>th` | Theme picker (live preview) |
| `<C-h/j/k/l>` | Navigate splits **and** zellij panes |
| `<C-Arrows>` | Resize split |
| `` <C-\> `` | Scratch terminal (float) |
| `<C-n>` | Multi-cursor: select next match |
| `<C-a>` / `<C-x>` | Increment / decrement (dial) |
| `w` `e` `b` `ge` | Sub-word motion (camelCase-aware) |
| `<M-h/j/k/l>` | Move line/selection |
| `<M-l>` (insert) | Accept Copilot suggestion |
| `<leader>a…` | **Claude**: `ac` toggle · `af` focus · `as` send sel · `ab` add file · `aa`/`ay` accept/deny diff · `ar` resume |
| `<leader>H…` + `<leader>1-4` | **Harpoon**: add/menu/prev/next + jump to slot |
| `<leader>gg` | Lazygit |
| `<leader>gd…` | Diffview: `dd` tree · `df` file history · `dh` branch · `dc` close |
| `<leader>gy` / `<leader>gY` | Git permalink: copy / open in browser |
| `<leader>co` | Symbol outline (aerial) |
| `<leader>fu` | Undo history |
| `<leader>fp` | Command palette (legendary) |
| `<leader>fP` | Projects |
| `<leader>sr` | Project-wide search & replace (grug-far) |
| `<leader>n…` | npm: `ns` show · `nu` update · `ni` install · `nc` change version |
| `<leader>Du` | Dadbod SQL UI |
| `<leader>o…` | Overseer: `ow` list · `or` run · `oa` action |
| `<leader>tr` / `<leader>tt` | Test nearest / file (Vitest) |
| `<leader>cP` / `<leader>uH` | Color picker / toggle swatches |
| `<leader>uz` / `<leader>uZ` | Zen mode / Twilight |
| `<leader>.` / `<leader>S` | Scratch buffer toggle / select |

## 5. zellij integration

**Default (zero zellij config):** `<C-h/j/k/l>` in nvim moves between splits, and
when you hit an edge, `zellij-nav` shells out to `zellij action move-focus` to cross
into the neighbouring zellij pane. Just make sure zellij isn't binding `Ctrl h/j/k/l`
itself (stock zellij doesn't). Moving *from* a non-nvim pane uses zellij's own keys
(default `Alt h/j/k/l`).

**Optional — fully symmetric nav** (so `Ctrl-hjkl` also works from non-nvim panes):
this needs the [`zellij-autolock`](https://github.com/fresh2dev/zellij-autolock) plugin
so zellij *locks* (stops intercepting) while nvim is focused, plus in `~/.config/zellij/config.kdl`:

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

⚠️ Only add the KDL binds **together with** autolock — otherwise zellij eats
`Ctrl-hjkl` before nvim sees them. Verify syntax against your zellij version (0.44).

## 6. BlackFox theme (pending)

The port isn't done yet — hand over the Zed BlackFox theme JSON (from
`~/.config/zed/themes/*.json` or the extensions dir) and I'll translate its color
roles into a `lua/blackfox.lua` (a `lush` spec), then switch the active colorscheme
in `lua/plugins/colorscheme.lua` from `tokyonight-night` to `blackfox`. `lush.nvim`
is already installed for exactly this.

## 7. Per-tool setup notes

- **win32yank** — install it (see §1) for clean clipboard; the config auto-detects it
  and falls back to OSC52 + PowerShell otherwise.
- **WakaTime** — first launch prompts for your API key → `~/.wakatime.cfg`.
- **Dadbod / MySQL** — add connections via an env var, never commit secrets:
  `export DBUI_MYSQL_DEV='mysql://user:pass@127.0.0.1:3306/db'`, then uncomment the
  `vim.g.dbs` line in `lua/plugins/lang.lua`.
- **Presence (Discord)** — likely won't connect from WSL without an IPC bridge; it's
  silent if it can't. `vyfor/cord.nvim` is a modern alternative.
- **Cypress** — no neotest adapter; run e2e via Overseer (`<leader>or`) or a terminal.

## 8. Deliberate deviations from the raw plugin list

- **blink.cmp** instead of nvim-cmp (LazyVim default, faster).
- **dressing.nvim dropped** — it's archived; `snacks.input` + Telescope ui-select replace it.
- **ccc.nvim added** alongside nvim-highlight-colors (the former is the actual picker).
- **zellij-nav = navigation, smart-splits = resize** — smart-splits can't cross into
  zellij panes, so duties are split to avoid a `Ctrl-hjkl` clash.
- **Copilot owns ghost-text**; blink's own ghost-text is disabled to avoid double suggestions.
