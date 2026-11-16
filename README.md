<div align="center">

# ⚔ FOR DORN ⚔

**A heavily customized Neovim setup built on LazyVim, themed after the Imperial Fists.**

![Neovim](https://img.shields.io/badge/Neovim-0.11+-57A143?logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/LazyVim-base-2E7DE9)
![Lua](https://img.shields.io/badge/Lua-config-000080?logo=lua&logoColor=white)
![Platforms](https://img.shields.io/badge/macOS%20%7C%20Linux%20%7C%20WSL-supported-e3b23c)

</div>

I moved here from Zed with vim motions. LazyVim is the scaffolding, and everything on
top of it is mine: a hand-built statusline, a ported color theme, a custom start screen,
and a full web dev workflow (Vue/JS/SCSS, SQL, tests, tasks) plus Rust and C/C++. Day to
day it runs inside a zellij pane on WSL, but the bootstrap script also sets it up on
macOS and regular Linux.

---

## Highlights

- **BlackFox theme**: a port of the BlackFox Zed theme. Near-black base, blue keywords,
  green italic comments, rose strings, teal types, gold functions. 20 other themes
  are installed too, with a live-preview picker on `<leader>th`.
- **Hand-built heirline statusline** in Imperial Fists black and gold: a mode badge,
  git branch and diff counts, diagnostics, active LSPs, the file and a ruler.
- **"FOR DORN" dashboard**: a block-letter banner, a random Rogal Dorn quote on
  each launch, and a quick-action menu.
- **AI built in**: Copilot ghost-text completion, plus Claude Code in a split
  through `claudecode.nvim`. It uses the authenticated `claude` CLI, so no API key
  is needed.
- **Plays well with zellij**: `Ctrl-hjkl` moves between Neovim splits and continues
  into neighbouring zellij panes.
- **One-command setup**: `bootstrap.sh` installs every dependency on
  macOS/apt/dnf/pacman/zypper, downloads a Nerd Font, links the config and installs
  the plugins.
- **Reproducible**: `lazy-lock.json` is committed, so every machine gets the same
  plugin versions.

---

## Features

`<leader>` is <kbd>Space</kbd>. Press it and wait, and which-key shows every
binding.

### 🤖 Completion & AI
| Feature | Plugin | Keys |
|---|---|---|
| Fast fuzzy completion with snippets | blink.cmp, LuaSnip, friendly-snippets | `<C-space>` · `<Tab>` |
| Copilot ghost-text (blink's own ghost-text is turned off so they don't overlap) | copilot.lua | `<M-l>` accept · `<M-]>`/`<M-[>` cycle · `<C-]>` dismiss |
| Claude Code in a right-hand split: send selections and files, review its diffs | claudecode.nvim | `<leader>ac` toggle · `as` send selection · `ab` add file · `aa`/`ay` accept/deny diff · `ar` resume · `am` model |

### 🧠 LSP, formatting & diagnostics
| Feature | Plugin | Keys |
|---|---|---|
| Language servers installed automatically, max two at a time so WSL doesn't stall | mason.nvim, nvim-lspconfig | `gd` `gr` `K` · `<leader>ca` action · `<leader>cr` rename |
| Format on demand only, so saving doesn't reformat code you didn't touch. In visual mode it formats just the selection | conform.nvim (Prettier, stylua, rustfmt, clang-format, shfmt) | `<leader>cf` · `<leader>uf` toggles format-on-save |
| Linting (eslint, markdownlint, shellcheck) | nvim-lint | automatic |
| Cleaner inline diagnostics | tiny-inline-diagnostic.nvim | automatic |
| Diagnostics and references in a navigable list | trouble.nvim | `<leader>xx` |
| LSP progress spinner | fidget.nvim | automatic |

**Servers:** vtsls, vue_ls (hybrid mode), eslint, cssls, jsonls (+ SchemaStore), bashls,
dockerls, docker-compose, yamlls, marksman, clangd, rust-analyzer, lua_ls.

### 🎨 Theme & UI
| Feature | Plugin | Keys |
|---|---|---|
| BlackFox colorscheme | `colors/blackfox.lua` | active by default |
| 20-theme library with live preview | tokyonight, catppuccin, kanagawa, rose-pine, gruvbox, nightfox, … | `<leader>th` |
| Custom Imperial Fists statusline | heirline.nvim | automatic |
| "FOR DORN" start screen | snacks.nvim dashboard | `nvim` with no file |
| Buffer tabs with diagnostics | bufferline.nvim | `<S-h>`/`<S-l>` |
| Reworked cmdline, search and messages | noice.nvim | `<leader>sn` history |
| Floating filename in each window | incline.nvim | automatic |
| Scrollbar with git/diagnostic/search markers | satellite.nvim | automatic |
| Indent guides with current-scope highlight | indent-blankline.nvim | automatic |
| Inline color swatches and a color picker | nvim-highlight-colors, ccc.nvim | `<leader>uH` swatches · `<leader>cP` picker |

### ✏️ Editing
| Feature | Plugin | Keys |
|---|---|---|
| Surround add/change/delete | mini.surround | `gsa` · `gsd` · `gsr` |
| Treesitter-aware autopairs with fast-wrap | nvim-autopairs | `<M-e>` |
| Auto-close and rename HTML/Vue/JSX tags | nvim-ts-autotag | automatic |
| Move lines and selections | mini.move | `<M-h/j/k/l>` |
| Increment and toggle numbers, hex, dates, booleans, semver, `let`↔`const`, `&&`↔`\|\|`, CSS units | dial.nvim | `<C-a>` / `<C-x>` |
| Motions that stop at camelCase and snake_case boundaries | nvim-spider | `w` `e` `b` `ge` |
| Yank ring and history | yanky.nvim | `<leader>p` |
| Multi-cursor in the VSCode/Zed style | vim-visual-multi | `<C-n>` next match · `<C-Up/Down>` add cursor |
| Indent width detected per file | vim-sleuth | automatic |
| Halve the indentation of a selection (4 → 2 spaces) | built-in | `<leader>i2` (visual) |

### 🧭 Motion & navigation
| Feature | Plugin | Keys |
|---|---|---|
| Jump anywhere in 2–3 keystrokes | flash.nvim | `s` · `S` Treesitter select |
| Pin hot files and jump straight to them | harpoon (v2) | `<leader>Ha` add · `<leader>Hh` menu · `<leader>1–4` |
| Fuzzy finder (files, grep, buffers, symbols, keymaps) | telescope.nvim + fzf-native | `<leader><space>` · `<leader>/` · `<leader>,` |
| Undo history as a tree, with diffs | telescope-undo | `<leader>fu` |
| Symbol outline sidebar | aerial.nvim | `<leader>co` |
| Marks shown in the gutter | marks.nvim | `m{a-z}` |

### 📁 Files
| Feature | Plugin | Keys |
|---|---|---|
| Edit a directory like a buffer, with deletes going to the trash | oil.nvim | `-` parent dir · `<leader>-` float |
| Sidebar file tree | neo-tree.nvim | `<leader>e` |
| Auto-detected project roots and a project picker | project.nvim | `<leader>fP` |

### 🌿 Git
| Feature | Plugin | Keys |
|---|---|---|
| Gutter hunks and inline blame on the current line | gitsigns.nvim | `]h`/`[h` · `<leader>ghs` stage · `<leader>ghp` preview |
| Lazygit in a floating window | snacks.nvim | `<leader>gg` |
| Side-by-side diffs and file/branch history | diffview.nvim | `<leader>gdd` · `gdf` · `gdh` · `gdc` |
| Copy or open a permalink to the current line (GitHub, GitLab, Bitbucket) | gitlinker.nvim | `<leader>gy` / `<leader>gY` |
| Merge-conflict resolution | git-conflict.nvim | `co` ours · `ct` theirs · `cb` both · `]x`/`[x` |

### 🧪 Testing, tasks & tooling
| Feature | Plugin | Keys |
|---|---|---|
| Run Vitest tests from the buffer, with inline results | neotest + neotest-vitest | `<leader>tr` nearest · `<leader>tt` file · `<leader>ts` summary |
| Task runner for `package.json` scripts and `.vscode/tasks.json` | overseer.nvim | `<leader>ow` · `<leader>or` |
| Inline npm versions in `package.json`, with update/install | package-info.nvim | `<leader>ns` · `nu` · `ni` · `nc` |
| SQL client: browse tables, run queries (connections come from env vars) | vim-dadbod + dadbod-ui | `<leader>Du` · `<leader>s` runs the query in SQL buffers |
| Rust and Cargo.toml support | rustaceanvim, crates.nvim | LSP keys |
| C/C++ with inlay hints | clangd_extensions | LSP keys |
| Markdown rendered in the buffer | render-markdown.nvim | automatic |

### 🖥 Terminal & workflow
| Feature | Plugin | Keys |
|---|---|---|
| Move between splits and zellij panes | zellij-nav.nvim | `<C-h/j/k/l>` |
| Resize splits | smart-splits.nvim | `<C-Arrows>` |
| Floating scratch terminal | toggleterm.nvim | `` <C-\> `` |
| Searchable command and keymap palette | legendary.nvim | `<leader>fp` |
| Project-wide search and replace | grug-far.nvim | `<leader>sr` |
| Session restore for each directory | persistence.nvim | `<leader>qs` · `<leader>ql` |
| Scratch buffers | snacks.nvim | `<leader>.` · `<leader>S` |

### ✨ Quality of life
- **Autosave**: every modified buffer is written once a minute.
- **Reloads files changed on disk**, for example when Claude Code edits a file in
  another zellij pane. It checks often, because zellij pane switches don't trigger
  Neovim's focus events.
- **WSL clipboard bridge**: uses `win32yank` if it's installed, and otherwise
  OSC52 for copy and PowerShell for paste (with `\r` removed).
- **Centered jumps**: `<C-d>`, `<C-u>`, `n` and `N` keep the cursor in the middle of
  the screen.
- **Paste over a selection without losing the yank** (`<leader>p` in visual mode),
  plus an explicit system-clipboard yank (`<leader>y`).
- **Zen mode and Twilight** for focused writing (`<leader>uz` / `<leader>uZ`), and
  subtle cursor and resize animations from mini.animate.
- **Discord Rich Presence** that never shows file or project names, only a
  rotating 40k-themed status line. Plus **WakaTime** time tracking.

---

## Installation

> Requires Neovim **0.11+**, git, a C compiler, Node 18+, ripgrep, fd and a
> [Nerd Font](https://www.nerdfonts.com/). The bootstrap script installs all of these.

```sh
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null   # back up any existing config
git clone https://github.com/ejdhindsa/neovim-config.git ~/.config/nvim
~/.config/nvim/bootstrap.sh
```

The script is idempotent, so it's safe to run again. If you clone somewhere
else, it backs up any existing `~/.config/nvim` and links the clone there.
Optional flags:

| Flag | Effect |
|---|---|
| `--with-rust` | Install the rustup toolchain |
| `--with-zellij` | Install zellij |
| `--with-claude` | Install the Claude Code CLI |
| `--no-font` | Skip the JetBrainsMono Nerd Font download |
| `--no-bootstrap` | Skip the headless plugin install |

<details>
<summary><b>Without the bootstrap script</b></summary>

If you already have the dependencies, clone the repo into `~/.config/nvim` (as
above) and run `nvim`. lazy.nvim installs the plugins and Mason installs the
language servers.

On Ubuntu, `fd` is installed as `fdfind`, so add a shim:
`ln -sf "$(command -v fdfind)" ~/.local/bin/fd`.

</details>

### First launch
1. Run `nvim` and wait for Mason to finish installing the language servers (1–2 minutes).
2. Run `:Copilot auth` to sign in for Copilot ghost-text.
3. Run `claude` in a terminal and `/login`, if you want the Claude Code split.
4. Run `:checkhealth` to confirm everything is green.

### Optional setup
- **Database connections**: export `DBUI_STORE` / `DBUI_CORP` as
  `mysql://user:pass@host:port/db` somewhere outside this repo (for example, a
  shell file that isn't tracked), or edit `vim.g.dbs` in `lua/plugins/lang.lua`.
- **WakaTime**: on first launch it asks for your API key and saves it to `~/.wakatime.cfg`.
- **WSL clipboard**: put [win32yank](https://github.com/equalsraf/win32yank/releases)
  on your PATH for the cleanest two-way clipboard.
- **Discord presence**: from WSL it needs an IPC bridge to reach Discord. Without
  one it does nothing.

---

## zellij integration

With no zellij config, `<C-h/j/k/l>` already moves between Neovim splits. At the
edge of the editor, it calls `zellij action move-focus` to cross into the next
pane.

For **symmetric** navigation, so `Ctrl-hjkl` also works from non-Neovim panes,
install [zellij-autolock](https://github.com/fresh2dev/zellij-autolock) and add this
to `~/.config/zellij/config.kdl`:

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

> ⚠️ Only add these binds together with autolock. Without it, zellij takes
> `Ctrl-hjkl` before Neovim sees them.

---

## Layout

```
├── init.lua
├── bootstrap.sh          one-shot installer
├── neovim-setup.md       detailed guide to every plugin
├── colors/blackfox.lua   the BlackFox colorscheme
├── lua/config/           lazy bootstrap, options, keymaps, autocmds
└── lua/plugins/          one file per area
    ├── claude.lua        coding.lua      color-tools.lua   colorscheme.lua
    ├── editing.lua       files.lua       fun.lua           git.lua
    ├── heirline.lua      lang.lua        mason.lua         motion.lua
    ├── multicursor.lua   snacks.lua      tasks.lua         telescope.lua
    └── terminal.lua      testing.lua     ui.lua            workflow.lua
```

**LazyVim extras** are enabled in `lua/config/lazy.lua`, not via `:LazyExtras`:
telescope, mini-surround, yanky, copilot, test.core, prettier, and the vue, json,
docker, markdown, rust, clangd and sql language extras.

For a plugin-by-plugin guide, see [`neovim-setup.md`](neovim-setup.md).

### Design choices
- **blink.cmp** instead of nvim-cmp, because it's faster (LazyVim's default).
- **heirline** instead of lualine, for a statusline built from scratch.
- **oil is the main file manager** and neo-tree is the backup sidebar. oil handles
  directory buffers.
- **zellij-nav handles navigation and smart-splits handles resizing**, so the two
  plugins don't compete for `Ctrl-hjkl`.
- **No format-on-save**, so diffs only contain the lines I actually changed.
- **dressing.nvim was dropped** because it's archived. snacks.input and Telescope
  ui-select replace it.

---

## Credits

- [LazyVim](https://github.com/LazyVim/LazyVim) by folke, the foundation for all of this.
- The BlackFox theme by Matej Cerny, ported here from Zed.
- Every plugin author listed in [`neovim-setup.md`](neovim-setup.md).
