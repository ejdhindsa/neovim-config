# Neovim Setup — Field Guide

A detailed tour of everything in this config: what each plugin does, how to use
it, and where it came from. Built on **LazyVim** (WSL/Ubuntu, Neovim 0.11.x,
inside a zellij pane).

**Leader key = `<Space>`.** Throughout, `<leader>` means Space.

### How to explore it yourself
- `:Lazy` — the plugin manager. Shows every plugin, whether it's loaded, and why.
- `:Lazy profile` — startup times and load reasons.
- **which-key**: press `<leader>` (or `g`, `]`, `[`, `"`, `z`) and *wait* — a popup lists what's available. This is your live cheat-sheet.
- `<leader>th` — live theme picker with preview.
- `<leader>sk` — search all keymaps (Telescope).

### Source legend
- 🟡 **Added** — a plugin you specifically asked for / I added for you.
- 🔵 **Extra** — a LazyVim "extra" I enabled in `lua/config/lazy.lua`.
- ⚪ **Default** — ships with LazyVim; you're inheriting it.

### Lazy-loading note
Most plugins load on-demand (opening a file, entering insert mode, pressing a key,
running a command), so `:Lazy` showing "X/Y loaded" is normal — the number climbs
as you work. Nothing is broken.

---

## 1. Framework & libraries

| Plugin | What it does | Source |
|---|---|---|
| **LazyVim/LazyVim** | The base distribution — sensible defaults for LSP, completion, Treesitter, git, keymaps. We treat it as scaffolding and override freely. | ⚪ |
| **folke/lazy.nvim** | The plugin manager itself. `:Lazy` to manage; `lazy-lock.json` pins versions for reproducibility. | ⚪ |
| **nvim-lua/plenary.nvim** | Lua utility library many plugins depend on (async, paths, etc.). | ⚪ |
| **MunifTanjim/nui.nvim** | UI-component library used by noice, neo-tree, package-info. | ⚪ |
| **folke/snacks.nvim** | Folke's QOL toolkit — powers the dashboard, notifications, lazygit, scratch buffers, big-file handling, and more (see §6/§10). | ⚪ |

---

## 2. Completion & AI

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **saghen/blink.cmp** | The completion engine (Rust-fuzzy, fast). Its own ghost-text is **off** so Copilot owns that. | `<C-space>` open, `<C-n>/<C-p>` cycle, `<CR>`/`<Tab>` accept, `<C-e>` cancel | ⚪ |
| **L3MON4D3/LuaSnip** + **friendly-snippets** | Snippet engine + a big community snippet collection. | `<Tab>`/`<S-Tab>` jump between placeholders | ⚪ |
| **zbirenbaum/copilot.lua** | GitHub Copilot **ghost-text** autocomplete (rides your Copilot subscription). Run `:Copilot auth` once. | `<M-l>` accept · `<M-]>`/`<M-[>` next/prev · `<C-]>` dismiss | 🔵 |
| **coder/claudecode.nvim** | Drives the authenticated `claude` CLI in a split — Claude Code on your subscription, **no API key**. | `<leader>ac` toggle · `<leader>af` focus · `<leader>as` send selection (visual) · `<leader>ab` add file · `<leader>aa`/`<leader>ay` accept/deny diff · `<leader>ar` resume · `<leader>aC` continue · `<leader>am` model | 🟡 |

---

## 3. LSP, formatting, linting & diagnostics

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **neovim/nvim-lspconfig** | Wires up the language servers. | `gd` def · `gr` refs · `gI` impl · `gy` type-def · `K` hover · `<leader>ca` code action · `<leader>cr` rename · `<leader>cc` codelens · `]d`/`[d` next/prev diagnostic | ⚪ |
| **mason-org/mason.nvim** (+ mason-lspconfig) | Installs LSP servers, formatters, linters. Throttled to **2 concurrent installs** so first launch doesn't stall WSL. | `:Mason` · `<leader>cm` | ⚪ / 🟡(throttle) |
| **stevearc/conform.nvim** | Formatting. Prettier for JS/Vue/CSS/JSON/YAML/MD; stylua for Lua; rustfmt; clang-format; shfmt. | `<leader>cf` format · formats on save | ⚪ / 🔵(prettier) |
| **mfussenegger/nvim-lint** | Linting where an LSP doesn't cover it (eslint, markdownlint, shellcheck). | runs automatically on save/read | ⚪ |
| **folke/trouble.nvim** | A pretty, navigable list for diagnostics, references, quickfix, symbols. | `<leader>xx` diagnostics · `<leader>xX` buffer · `<leader>cs` symbols · `<leader>cl` LSP refs | ⚪ |
| **rachartier/tiny-inline-diagnostic.nvim** | Replaces the default virtual-text diagnostics with a nicer inline presentation. Default `virtual_text` is turned off in favor of this. | automatic | 🟡 |
| **j-hui/fidget.nvim** | Little LSP-progress spinner in the corner (noice's LSP progress is disabled so this owns it). | automatic | 🟡 |
| **folke/lazydev.nvim** | Makes editing *this Lua config* pleasant — full Neovim API completion. | automatic in Lua | ⚪ |
| **b0o/SchemaStore.nvim** | Auto JSON schemas for `package.json`, `tsconfig.json`, etc. | automatic in JSON | 🔵 |

**LSP servers installed (via Mason):** `vtsls` (JS/TS intellisense), `vue_ls` (Volar, Vue SFCs, hybrid mode with vtsls), `eslint`, `cssls`, `jsonls`, `bashls`, `dockerls` + `docker_compose_language_service`, `yamlls`, `marksman` (Markdown), `clangd` (C/C++), `rust_analyzer` (via rustaceanvim), `lua_ls`.

---

## 4. Treesitter (syntax, structure, text objects)

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **nvim-treesitter/nvim-treesitter** | Fast, accurate syntax highlighting + structural parsing. Parsers installed for your whole stack: js, jsdoc, ts, tsx, vue, css, scss, html, json, yaml, toml, dockerfile, sql, rust, cpp, c, markdown, bash, lua, regex, gitcommit, diff, and more. | `:TSUpdate` to update | ⚪ / 🟡(parsers) |
| **nvim-treesitter-textobjects** | Select/move by function, class, parameter. | `af`/`if` function · `ac`/`ic` class · `aa`/`ia` argument · `]f`/`[f` next/prev function | ⚪ |
| **windwp/nvim-ts-autotag** | Auto-close & auto-rename HTML/Vue/JSX tags. | automatic in markup | 🟡 |
| **folke/ts-comments.nvim** | Context-aware commenting (correct comment syntax inside `.vue` template vs script vs style). | `gcc` line · `gc` (visual) · `gbc` block | ⚪ |

---

## 5. Colorscheme & theming

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **BlackFox** (`colors/blackfox.lua`) | **Your active theme** — a faithful port of your Zed BlackFox theme (near-black base, blue keywords, green italic comments, rose strings, teal types, amber/gold functions). | active on launch; edit any highlight in the file | 🟡 |
| **rktjmp/lush.nvim** | Colorscheme-authoring toolkit (was going to be the BlackFox vehicle; kept for building/tweaking themes live). | `:Lushify` | 🟡 |
| **Theme library** | Installed for browsing via `<leader>th`: tokyonight, catppuccin, kanagawa, rose-pine, gruvbox, gruvbox-material, everforest, sonokai, edge, nightfox, oxocarbon, nord, onedark, onedarkpro, modus, dracula, vscode, github, material, bamboo. | `<leader>th` preview & pick | 🟡 |
| **brenoprata10/nvim-highlight-colors** | Inline swatches for `#hex`, `rgb()`, `hsl()`, named colors (great in Sass). | `<leader>uH` toggle | 🟡 |
| **uga-rosa/ccc.nvim** | Interactive color picker / converter — sit on a color and edit it. | `<leader>cP` pick · `:CccConvert` | 🟡 |

---

## 6. Statusline, UI & start screen

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **rebelot/heirline.nvim** | Your **custom statusline**, hand-built and themed after the Imperial Fists (black + gold, mode badge, git, diagnostics, LSP, file, ruler). Replaces lualine. | automatic | 🟡 |
| **Snacks dashboard** | The **FOR DORN** start screen (Imperial Fists gold-on-black, rotating Rogal Dorn quote, quick-action menu). | shown on `nvim` with no file | 🟡 (config) |
| **akinsho/bufferline.nvim** | Tab-style buffer bar along the top with diagnostics + a neo-tree offset. | `<S-h>`/`<S-l>` prev/next · `[b`/`]b` · `<leader>bd` close · `<leader>bp` pin | ⚪ |
| **folke/noice.nvim** | Rethinks the cmdline / messages / popupmenu (command palette, centered search, bordered LSP docs). | `<leader>sn` message history | ⚪/🟡(tuned) |
| **b0o/incline.nvim** | Floating filename + icon in each window's top-right corner (handy with splits). | automatic | 🟡 |
| **lewis6991/satellite.nvim** | Scrollbar with diagnostic / git / search markers. | automatic | 🟡 |
| **lukas-reineke/indent-blankline.nvim** | Indent guides + current-scope highlight. | automatic | 🟡 |
| **folke/which-key.nvim** | The popup that shows available keybinds after a prefix. Custom groups labeled (claude, harpoon, npm, overseer, diffview, database). | press any prefix and wait | ⚪ |
| **folke/snacks.nvim** (notifier, input, words, bigfile, quickfile) | Pretty notifications; nicer `vim.ui.input`; highlight/jump references under cursor; smooth handling of huge files. | `]]`/`[[` next/prev reference | ⚪ |

---

## 7. Editing

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **echasnovski/mini.surround** | Add/change/delete surrounding quotes/brackets/tags. | `gsa` add · `gsd` delete · `gsr` replace (e.g. `gsaiw"`) | 🔵 |
| **windwp/nvim-autopairs** | Auto-closes brackets/quotes (Treesitter-aware). Replaces LazyVim's mini.pairs. | automatic · `<M-e>` fast-wrap | 🟡 |
| **echasnovski/mini.ai** | Smarter text objects — function, argument, and more, with `a`/`i` variants. | `ci(`, `daf`, `via`, etc. | ⚪ |
| **echasnovski/mini.move** | Move lines/selections around. | `<M-h/j/k/l>` (Alt + hjkl) | 🟡 |
| **monaqa/dial.nvim** | Increment/decrement numbers, dates, booleans, hex, semver, css units. | `<C-a>` inc · `<C-x>` dec (also in visual + `g<C-a>` ramp) | 🟡 |
| **chrisgrieser/nvim-spider** | `w`/`e`/`b`/`ge` stop at camelCase & snake_case sub-words. | `w` `e` `b` `ge` (n/o/x modes) | 🟡 |
| **gbprod/yanky.nvim** | Yank ring + history you can cycle/search. | `<leader>p` yank history · `<C-n>`/`<C-p>` cycle after paste | 🔵 |
| **tpope/vim-repeat** | Makes `.` repeat plugin actions (surround, etc.), not just native edits. | `.` | 🟡 |
| **tpope/vim-sleuth** | Auto-detects indent width/style per file. | automatic | 🟡 |
| **mg979/vim-visual-multi** | VSCode/Zed-style multi-cursor. *Note: a bolt-on emulating VSCode behaviour — vim-native `gn`/macros/`:s` are more powerful long-term.* | `<C-n>` select next match · `<C-Down>/<C-Up>` add cursor · `q` skip · `<Esc>` exit | 🟡 |

---

## 8. Motion & navigation

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **folke/flash.nvim** | Jump anywhere in 2–3 keystrokes; supercharges `f`/`t` and Treesitter selection. | `s` jump · `S` Treesitter select · `f`/`t` enhanced | ⚪ |
| **leap.nvim** | Optional alternative to flash (**disabled** by default so it doesn't fight for `s`; flip `enabled` in `motion.lua` to try). | — | 🟡 (off) |
| **ThePrimeagen/harpoon** (v2) | Pin your 4–5 hot files and jump instantly — faster than re-searching. | `<leader>Ha` add · `<leader>Hh` menu · `<leader>1`–`<leader>4` jump to slot · `<leader>Hp`/`<leader>Hn` prev/next | 🟡 |
| **stevearc/aerial.nvim** | Symbol outline sidebar (like Zed's outline). Pinned to the `nvim-0.11` branch. | `<leader>co` toggle | 🟡 |
| **chentoast/marks.nvim** | Shows marks in the gutter + better mark management. | `m` + letter to set; marks show in gutter | 🟡 |
| **nvim-telescope/telescope.nvim** (+ fzf-native) | Fuzzy finder for files, grep, buffers, symbols — the **picker backend**. | `<leader><space>`/`<leader>ff` files · `<leader>/`/`<leader>sg` live grep · `<leader>,` buffers · `<leader>fr` recent · `<leader>ss` symbols · `<leader>sk` keymaps | 🔵 |
| **debugloop/telescope-undo.nvim** | Browse undo history as a tree with diffs. | `<leader>fu` | 🟡 |

---

## 9. File management

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **stevearc/oil.nvim** | **Primary** file manager — edit a directory like a text buffer (rename/create/delete by editing lines, then `:w`). | `-` open parent dir · `<leader>-` floating | 🟡 |
| **nvim-neo-tree/neo-tree.nvim** | **Backup** sidebar tree (closest to Zed's project panel). netrw hijack disabled so oil owns directories. | `<leader>e` toggle · `<leader>fe` (root) | ⚪ |

---

## 10. Git

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **lewis6991/gitsigns.nvim** | Gutter hunks + **inline blame** on the current line. | `]h`/`[h` next/prev hunk · `<leader>ghs` stage · `<leader>ghr` reset · `<leader>ghp` preview · `<leader>ghb` blame line | ⚪/🟡(blame on) |
| **Snacks lazygit** | Full lazygit TUI in a float — just needs the lazygit binary (you have it). | `<leader>gg` | ⚪ |
| **sindrets/diffview.nvim** | Side-by-side diffs + file/branch history (PR-review style). | `<leader>gdd` working tree · `<leader>gdf` file history · `<leader>gdh` branch history · `<leader>gdc` close | 🟡 |
| **linrongbin16/gitlinker.nvim** | Yank / open a permalink to the current line (Bitbucket supported). | `<leader>gy` copy link · `<leader>gY` open in browser (n + visual) | 🟡 |
| **akinsho/git-conflict.nvim** | Highlighted merge-conflict resolution. | `co` ours · `ct` theirs · `cb` both · `c0` none · `]x`/`[x` navigate | 🟡 |
| **Snacks gitbrowse** | Open the current file/line on the remote host in your browser. | `<leader>gB` | ⚪ |

---

## 11. Terminal & multiplexer

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **swaits/zellij-nav.nvim** | `Ctrl-hjkl` moves between nvim splits **and** crosses into neighbouring zellij panes. | `<C-h/j/k/l>` | 🟡 |
| **mrjones2014/smart-splits.nvim** | Split **resizing** (kept off `Ctrl-hjkl` so it doesn't clash with zellij-nav). | `<C-Up/Down/Left/Right>` resize | 🟡 |
| **akinsho/toggleterm.nvim** | Quick **scratch** terminals only — zellij still owns your real pane/tab layout. | `` <C-\> `` float terminal | 🟡 |

---

## 12. Testing & tasks

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **nvim-neotest/neotest** + **neotest-vitest** | Run/debug individual Vitest tests from the buffer with inline pass/fail marks. *(Cypress has no adapter — run e2e via Overseer or a terminal.)* | `<leader>tr` run nearest · `<leader>tt` run file · `<leader>ts` summary · `<leader>to` output · `<leader>tS` stop | 🔵/🟡 |
| **stevearc/overseer.nvim** | Task runner — runs `package.json` scripts, build steps, Cypress, `.vscode/tasks.json`. | `<leader>ow` task list · `<leader>or` run · `<leader>oa` quick action | 🟡 |

---

## 13. Language-specific tooling

| Plugin / tool | Language | What it does | Keys / usage | Source |
|---|---|---|---|---|
| **vue_ls + vtsls** | Vue 3 / JS | SFC intellisense in hybrid mode (vtsls also powers plain JS). | LSP keys (§3) | 🔵 |
| **vuki656/package-info.nvim** | JS | Shows latest/outdated dependency versions inline in `package.json`. | `<leader>ns` show · `<leader>nu` update · `<leader>ni` install · `<leader>nc` change version | 🟡 |
| **vim-dadbod** + **dadbod-ui** + **dadbod-completion** | SQL/MySQL | In-editor SQL client — browse tables, run queries. Add connections via an env var (never commit secrets). | `<leader>Du` toggle DB UI | 🔵 |
| **mrcjkb/rustaceanvim** + **crates.nvim** | Rust | Best-in-class Rust LSP/DAP wrapper + `Cargo.toml` version help. | rust-analyzer code actions; crates inline | 🔵 |
| **clangd + clangd_extensions** | C/C++ | LSP + inlay hints, switch source/header. | `<leader>ch`? via clangd; LSP keys | 🔵 |
| **MeanderingProgrammer/render-markdown.nvim** | Markdown | Renders headings/tables/code blocks *in-buffer* (WSL-friendly; no browser needed). | automatic in `.md` | 🔵/🟡 |
| **marksman** | Markdown | LSP for links, references, workspace symbols. | LSP keys | 🔵 |

---

## 14. Workflow & sessions

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **folke/persistence.nvim** | Per-directory session save/restore. | `<leader>qs` restore · `<leader>ql` restore last · `<leader>qd` don't save | ⚪ |
| **mrjones2014/legendary.nvim** | Searchable command/keymap palette (Zed's Cmd-P-for-commands feel). | `<leader>fp` | 🟡 |
| **MagicDuck/grug-far.nvim** | Project-wide find & replace UI (Zed's multi-file replace). | `<leader>sr` (n + visual) | 🟡 |
| **ahmedkhalf/project.nvim** | Auto-detects project roots + a Telescope picker for them. | `<leader>fP` projects | 🟡 |

---

## 15. Fun & polish

| Plugin | What it does | Keys / usage | Source |
|---|---|---|---|
| **folke/zen-mode.nvim** + **twilight.nvim** | Distraction-free mode; twilight dims inactive code. | `<leader>uz` zen · `<leader>uZ` twilight | 🟡 |
| **echasnovski/mini.animate** | Subtle cursor/resize animations (scroll animation intentionally off — laggy over WSL). | automatic | 🟡 |
| **andweeb/presence.nvim** | Discord Rich Presence. *WSL caveat: won't reach Discord's IPC socket without a bridge; harmless if it can't.* | automatic | 🟡 |
| **wakatime/vim-wakatime** | Coding-time tracking. First launch prompts for your API key → `~/.wakatime.cfg`. | `:WakaTimeApiKey` | 🟡 |

---

## Quick "getting started" path
1. Open `nvim` → FOR DORN dashboard. Press `f` to find a file, or `<leader>e` for the tree.
2. Learn these five first: `<leader>ff` (files), `<leader>/` (grep), `s` (flash jump), `<leader>Ha`/`<leader>1` (harpoon), `<leader>gg` (lazygit).
3. When unsure of a key: press `<leader>` and read the which-key popup.
4. Browse themes with `<leader>th`; everything is yours to edit under `lua/plugins/`.

*Full keybinding cheat-sheet: see `README.md` §4.*
