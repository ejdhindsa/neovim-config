# Every plugin in this config

This is the long version of the README. It lists every plugin I use, what it's for and
the keys I use with it. A lot of these come with LazyVim and I just left them on.
The ones I added or changed are in `lua/plugins/`, and the LazyVim extras I turned
on are in `lua/config/lazy.lua`.

Leader is <kbd>Space</kbd>.

Some useful places to look:

- `:Lazy` shows every plugin and whether it's loaded. Most of them load when you
  first need them, so seeing "40/106 loaded" is normal.
- `:Lazy profile` shows startup times.
- Press `<leader>` (or `g`, `[`, `]`, `z`) and wait, and which-key lists what you can press next.
- `<leader>sk` searches every keymap.

## Base

- **LazyVim**: the defaults for LSP, completion, treesitter, git and keymaps. I override
  whatever I don't like.
- **lazy.nvim**: the plugin manager. `lazy-lock.json` pins the versions.
- **snacks.nvim**: does a lot of small things: the start screen, notifications,
  lazygit, scratch buffers and handling big files.
- **plenary.nvim** and **nui.nvim**: libraries that other plugins need.

## Completion and AI

| Plugin | What it does | Keys |
|---|---|---|
| blink.cmp | Completion. I turned off its ghost text because Copilot does that. | `<C-space>` open, `<C-n>`/`<C-p>` move, `<CR>`/`<Tab>` accept, `<C-e>` close |
| LuaSnip + friendly-snippets | Snippets | `<Tab>`/`<S-Tab>` jump between fields |
| copilot.lua | Copilot ghost text. Run `:Copilot auth` once. | `<M-l>` accept, `<M-]>`/`<M-[>` next/prev, `<C-]>` dismiss |
| claudecode.nvim | Claude Code in a split on the right. It uses the `claude` CLI, so you need to be logged in there. | `<leader>ac` toggle, `<leader>af` focus, `<leader>as` send selection, `<leader>ab` add file, `<leader>aa`/`<leader>ay` accept/reject diff, `<leader>ar` resume, `<leader>aC` continue, `<leader>am` model |

## LSP, formatting and diagnostics

| Plugin | What it does | Keys |
|---|---|---|
| nvim-lspconfig | Sets up the language servers | `gd` definition, `gr` references, `gI` implementation, `gy` type, `K` hover, `<leader>ca` code action, `<leader>cr` rename, `]d`/`[d` next/prev diagnostic |
| mason.nvim | Installs language servers, formatters and linters. Set to 2 at a time, because more than that froze WSL on the first launch. | `:Mason`, `<leader>cm` |
| conform.nvim | Formatting: Prettier for web stuff, stylua, rustfmt, clang-format, shfmt. Format on save is off. | `<leader>cf` (only the selection in visual mode), `<leader>uf` turns format on save back on |
| nvim-lint | eslint, markdownlint and shellcheck where the LSP doesn't cover it | runs on its own |
| trouble.nvim | A list of diagnostics, references and symbols you can jump through | `<leader>xx`, `<leader>xX` (this buffer), `<leader>cs` symbols |
| tiny-inline-diagnostic | Nicer inline error messages than the default | |
| fidget.nvim | Small LSP loading spinner in the corner | |
| lazydev.nvim | Completion for the Neovim API when editing this config | |
| SchemaStore.nvim | JSON schemas for `package.json`, `tsconfig.json` and so on | |

Language servers: vtsls, vue_ls (in hybrid mode with vtsls), eslint, cssls, jsonls,
bashls, dockerls, docker-compose, yamlls, marksman, clangd, rust-analyzer (through
rustaceanvim) and lua_ls.

## Treesitter

| Plugin | What it does | Keys |
|---|---|---|
| nvim-treesitter | Highlighting and parsing. I added parsers for everything I use (js, ts, vue, scss, sql, rust, c/cpp, docker and more). | `:TSUpdate` |
| treesitter-textobjects | Select or jump by function, class or argument | `af`/`if`, `ac`/`ic`, `aa`/`ia`, `]f`/`[f` |
| nvim-ts-autotag | Closes and renames HTML/Vue/JSX tags automatically | |
| ts-comments.nvim | Uses the right comment style in each part of a `.vue` file | `gcc` line, `gc` selection |

## Colors

| Plugin | What it does | Keys |
|---|---|---|
| BlackFox (`colors/blackfox.lua`) | My port of Matej Cerny's BlackFox theme from Zed. It's the theme I use. | |
| Other themes | tokyonight, catppuccin, kanagawa, rose-pine, gruvbox, gruvbox-material, everforest, sonokai, edge, nightfox, oxocarbon, nord, onedark, onedarkpro, modus, dracula, vscode, github, material, bamboo | `<leader>th` previews them |
| lush.nvim | For making themes. I ended up not using it for BlackFox, but kept it around. | `:Lushify` |
| nvim-highlight-colors | Shows a swatch next to hex/rgb/hsl colors | `<leader>uH` toggle |
| ccc.nvim | Color picker. Put the cursor on a color and edit it. | `<leader>cP` |

## UI

| Plugin | What it does | Keys |
|---|---|---|
| heirline.nvim | My statusline, made from scratch in Imperial Fists black and gold. It replaces lualine. | |
| snacks dashboard | The FOR DORN start screen | open `nvim` with no file |
| bufferline.nvim | Buffer tabs along the top | `<S-h>`/`<S-l>`, `<leader>bd` close, `<leader>bp` pin |
| noice.nvim | Moves the cmdline into a popup and puts borders on LSP docs | `<leader>sn` message history |
| incline.nvim | Filename in the top right of each split | |
| satellite.nvim | Scrollbar that shows git changes, errors and search results | |
| indent-blankline | Indent guides | |
| which-key.nvim | Shows what keys you can press next. I labeled my own groups (claude, harpoon, npm, overseer, diffview, database). | |
| snacks (notifier, words) | Notifications, and highlighting other uses of the word under the cursor | `]]`/`[[` jump between them |

## Editing

| Plugin | What it does | Keys |
|---|---|---|
| mini.surround | Add, change or delete quotes and brackets around things | `gsa`, `gsd`, `gsr` (for example `gsaiw"`) |
| nvim-autopairs | Auto-closes brackets. I use it instead of LazyVim's mini.pairs. | `<M-e>` wraps the next thing |
| mini.ai | More text objects | `daf`, `ci(`, `via` and so on |
| mini.move | Moves lines and selections | `<M-h/j/k/l>` |
| dial.nvim | `<C-a>` works on dates, booleans, hex, semver, `let`/`const`, `&&`/`\|\|` and CSS units too | `<C-a>`/`<C-x>`, `g<C-a>` in visual for a sequence |
| nvim-spider | `w`/`e`/`b` stop inside camelCase and snake_case words | `w`, `e`, `b`, `ge` |
| yanky.nvim | Yank history | `<leader>p` history, `<C-n>`/`<C-p>` after pasting to cycle |
| vim-repeat | Lets `.` repeat plugin actions | |
| vim-sleuth | Detects each file's indent size | |
| vim-visual-multi | Multi-cursor like VS Code/Zed. Vim's own `gn` and macros are probably better, but I'm used to this. | `<C-n>` next match, `<C-Up>`/`<C-Down>` add cursor, `q` skip, `<Esc>` exit |

## Getting around

| Plugin | What it does | Keys |
|---|---|---|
| flash.nvim | Jump anywhere with a couple of keys | `s`, `S` for treesitter selection |
| leap.nvim | Turned off because it fights flash for `s`. Enable it in `motion.lua` if you want it. | |
| harpoon | Pin a few files you keep going back to | `<leader>Ha` add, `<leader>Hh` menu, `<leader>1`-`4` jump, `<leader>Hp`/`<leader>Hn` prev/next |
| aerial.nvim | Symbol outline. On the `nvim-0.11` branch, because master needs 0.12. | `<leader>co` |
| marks.nvim | Shows marks in the gutter | `m` + a letter |
| telescope.nvim | Fuzzy finder | `<leader><space>` files, `<leader>/` grep, `<leader>,` buffers, `<leader>fr` recent, `<leader>ss` symbols |
| telescope-undo | Undo history as a tree, with diffs | `<leader>fu` |

## Files

| Plugin | What it does | Keys |
|---|---|---|
| oil.nvim | My main file manager. Edit the folder like a normal file, then `:w` to rename, create or delete files. Deleted files go to the trash. | `-` parent folder, `<leader>-` floating |
| neo-tree.nvim | Sidebar tree, for when I want the Zed-style view | `<leader>e` |

## Git

| Plugin | What it does | Keys |
|---|---|---|
| gitsigns.nvim | Changes in the gutter, and blame at the end of the current line | `]h`/`[h`, `<leader>ghs` stage, `<leader>ghr` reset, `<leader>ghp` preview |
| lazygit (snacks) | lazygit in a floating window. You need lazygit installed. | `<leader>gg` |
| diffview.nvim | Side-by-side diffs and file history | `<leader>gdd`, `<leader>gdf` file history, `<leader>gdh` branch history, `<leader>gdc` close |
| gitlinker.nvim | Copy or open a link to the current line on GitHub/Bitbucket | `<leader>gy` copy, `<leader>gY` open |
| git-conflict.nvim | Merge conflict helpers | `co` ours, `ct` theirs, `cb` both, `c0` none, `]x`/`[x` |
| gitbrowse (snacks) | Open the file on the remote | `<leader>gB` |

## Terminal and zellij

| Plugin | What it does | Keys |
|---|---|---|
| zellij-nav.nvim | Moves between splits, and into the next zellij pane at the edge | `<C-h/j/k/l>` |
| smart-splits.nvim | Resizes splits. It can't move into zellij panes, so zellij-nav handles that. | `<C-Arrows>` |
| toggleterm.nvim | A quick floating terminal. zellij is still where my real terminals live. | `` <C-\> `` |

## Tests and tasks

| Plugin | What it does | Keys |
|---|---|---|
| neotest + neotest-vitest | Run Vitest tests from the file and see pass/fail inline. Cypress has no adapter, so I run it with overseer. | `<leader>tr` nearest, `<leader>tt` file, `<leader>ts` summary, `<leader>to` output |
| overseer.nvim | Runs `package.json` scripts and `.vscode/tasks.json` | `<leader>ow` list, `<leader>or` run, `<leader>oa` actions |

## Language specific

| Plugin | For | What it does | Keys |
|---|---|---|---|
| vue_ls + vtsls | Vue / JS | Vue and JS support | normal LSP keys |
| package-info.nvim | npm | Shows outdated versions in `package.json` | `<leader>ns` show, `<leader>nu` update, `<leader>ni` install, `<leader>nc` change version |
| dadbod + dadbod-ui | SQL | SQL client. Connections come from env vars so no passwords end up in git. | `<leader>Du`, `<leader>s` runs the query in SQL files |
| rustaceanvim + crates.nvim | Rust | rust-analyzer, and version info in `Cargo.toml` | |
| clangd_extensions | C/C++ | Inlay hints, switch between source and header | `<leader>ch` |
| render-markdown.nvim | Markdown | Renders headings, tables and code blocks right in the buffer | |
| marksman | Markdown | LSP for links | |

## Workflow

| Plugin | What it does | Keys |
|---|---|---|
| persistence.nvim | Saves and restores sessions for each folder | `<leader>qs` restore, `<leader>ql` last, `<leader>qd` don't save |
| legendary.nvim | Searchable list of commands and keymaps | `<leader>fp` |
| grug-far.nvim | Find and replace across the project | `<leader>sr` |
| project.nvim | Detects project roots and has a project picker | `<leader>fP` |

## Extras

| Plugin | What it does | Keys |
|---|---|---|
| zen-mode + twilight | Distraction-free mode, with twilight dimming the code you're not in | `<leader>uz`, `<leader>uZ` |
| mini.animate | Small cursor and resize animations. Scroll animation is off because it lags in zellij. | |
| presence.nvim | Discord status. It doesn't show file or project names. On WSL it needs an IPC bridge to reach Discord. | |
| vim-wakatime | WakaTime tracking. It asks for your API key on the first launch. | `:WakaTimeApiKey` |

## If you're new to it

1. Open `nvim` and press `f` on the start screen to find a file.
2. Learn these first: `<leader><space>` files, `<leader>/` grep, `s` jump, `<leader>Ha`
   and `<leader>1` for harpoon, and `<leader>gg` for lazygit.
3. If you forget something, press `<leader>` and wait.
