-- BlackFox — Neovim port of the Zed theme by Matej Cerny.
-- Near-black base, blue keywords, green italic comments, rose strings,
-- teal types, and the signature amber/gold functions.
-- Loaded via `:colorscheme blackfox` (also appears in <leader>th).

vim.cmd("highlight clear")
if vim.g.syntax_on then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "blackfox"

local c = {
  bg = "#1E1F22",
  bg_dark = "#191A1C",
  bg_alt = "#2B2D30", -- floats / panels / surfaces
  bg_elev = "#393D3F", -- elements / statusline fill
  cursorline = "#26272B",
  border = "#33363D",
  fg = "#C2D1E0",
  fg_dim = "#bac2de",
  muted = "#9399b2",
  comment = "#759963",
  faint = "#6c7086",
  line_nr = "#606366",
  line_nr_active = "#A4A3A3",
  sel = "#343842",

  blue = "#6A95EB", -- keywords
  blue_br = "#89b4fa", -- constants / booleans / tags
  blue_num = "#7095CC", -- numbers
  accent = "#A5D0F8",
  amber = "#FFC66D", -- functions (the fox gold)
  amber_alt = "#f9e2af", -- attributes / modified
  orange = "#CC7832", -- escapes
  rose = "#CC7270", -- strings
  red = "#E19B9B", -- errors / deleted
  teal = "#47C9A7", -- types / enums
  mint = "#A2E4D2", -- created / literals
  cyan = "#94e2d5", -- punctuation / info
  cyan_br = "#00BBBD",
  mauve = "#dcb8d5", -- special variables
  pink = "#f5c2e7",
  warn = "#fab387",
  hint = "#eba0ac",
  white = "#cdd6f4", -- variables / titles
  none = "NONE",
}

local groups = {
  -- ── Editor UI ──────────────────────────────────────────────────────
  Normal = { fg = c.fg, bg = c.bg },
  NormalNC = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.fg, bg = c.bg_alt },
  FloatBorder = { fg = c.border, bg = c.bg_alt },
  FloatTitle = { fg = c.amber, bg = c.bg_alt, bold = true },
  ColorColumn = { bg = c.bg_alt },
  Cursor = { fg = c.bg, bg = c.fg },
  CursorLine = { bg = c.cursorline },
  CursorColumn = { bg = c.cursorline },
  CursorLineNr = { fg = c.amber, bold = true },
  LineNr = { fg = c.line_nr },
  LineNrAbove = { fg = c.line_nr },
  LineNrBelow = { fg = c.line_nr },
  SignColumn = { bg = c.none },
  FoldColumn = { fg = c.line_nr, bg = c.none },
  Folded = { fg = c.muted, bg = c.bg_alt },
  VertSplit = { fg = c.border },
  WinSeparator = { fg = c.border },
  Visual = { bg = c.sel },
  VisualNOS = { bg = c.sel },
  Search = { fg = c.bg, bg = c.amber_alt },
  IncSearch = { fg = c.bg, bg = c.amber },
  CurSearch = { fg = c.bg, bg = c.amber },
  MatchParen = { fg = c.amber, bold = true, underline = true },
  NonText = { fg = "#3A3D45" },
  Whitespace = { fg = "#3A3D45" },
  SpecialKey = { fg = c.faint },
  EndOfBuffer = { fg = c.bg },
  Conceal = { fg = c.muted },
  Directory = { fg = c.blue_br },
  Title = { fg = c.white, bold = true },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.warn },
  ModeMsg = { fg = c.fg_dim, bold = true },
  MoreMsg = { fg = c.mint },
  Question = { fg = c.mint },
  QuickFixLine = { bg = c.bg_elev },
  WildMenu = { fg = c.bg, bg = c.amber },

  StatusLine = { fg = c.fg, bg = c.bg_elev },
  StatusLineNC = { fg = c.faint, bg = c.bg_alt },
  TabLine = { fg = c.faint, bg = c.bg_alt },
  TabLineSel = { fg = c.amber, bg = c.bg },
  TabLineFill = { bg = c.bg_dark },
  WinBar = { fg = c.fg, bg = c.none },
  WinBarNC = { fg = c.faint, bg = c.none },

  -- Popup menu (also covers blink.cmp defaults)
  Pmenu = { fg = c.fg, bg = c.bg_alt },
  PmenuSel = { fg = c.white, bg = c.bg_elev, bold = true },
  PmenuKind = { fg = c.blue_br, bg = c.bg_alt },
  PmenuExtra = { fg = c.muted, bg = c.bg_alt },
  PmenuSbar = { bg = c.bg_alt },
  PmenuThumb = { bg = "#525456" },

  -- ── Syntax (legacy) ────────────────────────────────────────────────
  Comment = { fg = c.comment, italic = true },
  Constant = { fg = c.blue_br },
  String = { fg = c.rose },
  Character = { fg = c.rose },
  Number = { fg = c.blue_num },
  Float = { fg = c.blue_num },
  Boolean = { fg = c.blue_br },
  Identifier = { fg = c.fg },
  Function = { fg = c.amber, italic = true },
  Statement = { fg = c.blue },
  Conditional = { fg = c.blue },
  Repeat = { fg = c.blue },
  Label = { fg = c.blue },
  Operator = { fg = c.fg },
  Keyword = { fg = c.blue },
  Exception = { fg = c.blue },
  PreProc = { fg = c.blue },
  Include = { fg = c.blue },
  Define = { fg = c.blue },
  Macro = { fg = c.blue },
  Type = { fg = c.teal },
  StorageClass = { fg = c.blue },
  Structure = { fg = c.teal },
  Typedef = { fg = c.teal },
  Special = { fg = c.cyan_br },
  SpecialChar = { fg = c.orange },
  Tag = { fg = c.blue_br },
  Delimiter = { fg = c.muted },
  SpecialComment = { fg = c.comment, italic = true },
  Debug = { fg = c.red },
  Underlined = { fg = c.accent, underline = true },
  Error = { fg = c.red },
  Todo = { fg = c.bg, bg = c.amber, bold = true },

  -- ── Treesitter ─────────────────────────────────────────────────────
  ["@comment"] = { link = "Comment" },
  ["@comment.documentation"] = { fg = c.comment, italic = true },
  ["@comment.error"] = { fg = c.red },
  ["@comment.warning"] = { fg = c.warn },
  ["@comment.todo"] = { link = "Todo" },
  ["@comment.note"] = { fg = c.cyan },

  ["@keyword"] = { fg = c.blue },
  ["@keyword.function"] = { fg = c.blue },
  ["@keyword.return"] = { fg = c.blue },
  ["@keyword.operator"] = { fg = c.blue },
  ["@keyword.import"] = { fg = c.blue },
  ["@keyword.conditional"] = { fg = c.blue },
  ["@keyword.repeat"] = { fg = c.blue },
  ["@keyword.exception"] = { fg = c.blue },
  ["@conditional"] = { fg = c.blue },
  ["@repeat"] = { fg = c.blue },
  ["@include"] = { fg = c.blue },
  ["@exception"] = { fg = c.blue },

  ["@string"] = { fg = c.rose },
  ["@string.escape"] = { fg = c.orange },
  ["@string.regexp"] = { fg = c.orange },
  ["@string.special"] = { fg = c.pink },
  ["@string.special.symbol"] = { fg = "#f2cdcd" },
  ["@character"] = { fg = c.rose },
  ["@character.special"] = { fg = c.orange },

  ["@number"] = { fg = c.blue_num },
  ["@number.float"] = { fg = c.blue_num },
  ["@float"] = { fg = c.blue_num },
  ["@boolean"] = { fg = c.blue_br },

  ["@constant"] = { fg = c.blue_br },
  ["@constant.builtin"] = { fg = c.blue_br },
  ["@constant.macro"] = { fg = c.blue },

  -- Faithful to BlackFox: function *definitions* are gold, *calls* stay fg
  ["@function"] = { fg = c.amber, italic = true },
  ["@function.builtin"] = { fg = c.amber },
  ["@function.call"] = { fg = c.fg },
  ["@function.method"] = { fg = c.amber },
  ["@function.method.call"] = { fg = c.fg },
  ["@method"] = { fg = c.amber },
  ["@method.call"] = { fg = c.fg },
  ["@constructor"] = { fg = c.blue_br },

  ["@variable"] = { fg = c.white },
  ["@variable.builtin"] = { fg = c.mauve },
  ["@variable.parameter"] = { fg = c.fg },
  ["@variable.member"] = { fg = c.fg },
  ["@property"] = { fg = c.fg },
  ["@field"] = { fg = c.fg },

  ["@type"] = { fg = c.teal },
  ["@type.builtin"] = { fg = c.teal },
  ["@type.definition"] = { fg = c.teal },
  ["@type.qualifier"] = { fg = c.blue },
  ["@namespace"] = { fg = c.teal },
  ["@module"] = { fg = c.teal },
  ["@enum"] = { fg = c.teal, bold = true },

  ["@operator"] = { fg = c.fg },
  ["@punctuation.delimiter"] = { fg = c.muted },
  ["@punctuation.bracket"] = { fg = c.amber },
  ["@punctuation.special"] = { fg = c.cyan_br },
  ["@punctuation"] = { fg = c.cyan },

  ["@tag"] = { fg = c.blue_br },
  ["@tag.builtin"] = { fg = c.blue_br },
  ["@tag.attribute"] = { fg = c.amber_alt },
  ["@tag.delimiter"] = { fg = c.muted },
  ["@attribute"] = { fg = c.amber_alt },
  ["@label"] = { fg = c.blue },

  -- Markdown / markup
  ["@markup.heading"] = { fg = c.white, bold = true },
  ["@markup.heading.1"] = { fg = c.amber, bold = true },
  ["@markup.heading.2"] = { fg = c.blue_br, bold = true },
  ["@markup.heading.3"] = { fg = c.teal, bold = true },
  ["@markup.strong"] = { fg = c.red, bold = true },
  ["@markup.italic"] = { fg = c.red, italic = true },
  ["@markup.link"] = { fg = c.blue_br },
  ["@markup.link.url"] = { fg = c.blue_br, underline = true },
  ["@markup.raw"] = { fg = c.mint },
  ["@markup.list"] = { fg = c.cyan },
  ["@markup.quote"] = { fg = c.muted, italic = true },

  -- LSP semantic tokens → follow the treesitter groups
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.keyword"] = { link = "@keyword" },
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.enum"] = { link = "@enum" },
  ["@lsp.type.interface"] = { link = "@type" },
  ["@lsp.type.namespace"] = { link = "@namespace" },

  -- ── Diagnostics ────────────────────────────────────────────────────
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.warn },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticHint = { fg = c.hint },
  DiagnosticOk = { fg = c.mint },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.warn },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.cyan },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.hint },
  DiagnosticVirtualTextError = { fg = c.red, bg = "#2A2022" },
  DiagnosticVirtualTextWarn = { fg = c.warn, bg = "#2A2620" },
  DiagnosticVirtualTextInfo = { fg = c.cyan, bg = "#1F2A2A" },
  DiagnosticVirtualTextHint = { fg = c.hint, bg = "#2A2226" },

  -- ── Git / diff ─────────────────────────────────────────────────────
  DiffAdd = { bg = "#1F2A25" },
  DiffChange = { bg = "#2A2820" },
  DiffDelete = { bg = "#2C2020" },
  DiffText = { bg = "#3A3418" },
  diffAdded = { fg = c.mint },
  diffRemoved = { fg = c.red },
  diffChanged = { fg = c.amber_alt },
  GitSignsAdd = { fg = c.mint },
  GitSignsChange = { fg = c.amber_alt },
  GitSignsDelete = { fg = c.red },
  GitSignsCurrentLineBlame = { fg = c.faint, italic = true },

  -- ── Plugins ────────────────────────────────────────────────────────
  -- Telescope
  TelescopeNormal = { fg = c.fg, bg = c.bg_alt },
  TelescopeBorder = { fg = c.border, bg = c.bg_alt },
  TelescopeTitle = { fg = c.amber, bold = true },
  TelescopePromptNormal = { fg = c.fg, bg = c.bg_elev },
  TelescopePromptBorder = { fg = c.bg_elev, bg = c.bg_elev },
  TelescopePromptTitle = { fg = c.bg, bg = c.amber, bold = true },
  TelescopePromptPrefix = { fg = c.amber },
  TelescopeSelection = { bg = c.bg_elev, fg = c.white },
  TelescopeMatching = { fg = c.amber, bold = true },

  -- which-key
  WhichKey = { fg = c.blue },
  WhichKeyGroup = { fg = c.amber },
  WhichKeyDesc = { fg = c.fg },
  WhichKeySeparator = { fg = c.faint },
  WhichKeyBorder = { fg = c.border, bg = c.bg_alt },
  WhichKeyFloat = { bg = c.bg_alt },

  -- flash
  FlashLabel = { fg = c.bg, bg = c.amber, bold = true },
  FlashMatch = { fg = c.white, bg = c.bg_elev },
  FlashCurrent = { fg = c.bg, bg = c.amber_alt },

  -- indent-blankline
  IblIndent = { fg = "#2A2C31" },
  IblScope = { fg = c.faint },

  -- neo-tree / oil
  NeoTreeNormal = { fg = c.fg, bg = c.bg },
  NeoTreeNormalNC = { fg = c.fg, bg = c.bg },
  NeoTreeDirectoryName = { fg = c.blue_br },
  NeoTreeDirectoryIcon = { fg = c.blue_br },
  NeoTreeRootName = { fg = c.amber, bold = true },
  NeoTreeGitModified = { fg = c.amber_alt },
  NeoTreeGitAdded = { fg = c.mint },
  NeoTreeGitDeleted = { fg = c.red },
  OilDir = { fg = c.blue_br },
  OilFile = { fg = c.fg },

  -- misc
  LspInlayHint = { fg = c.faint, bg = c.bg_alt, italic = true },
  LspReferenceText = { bg = c.bg_elev },
  LspReferenceRead = { bg = c.bg_elev },
  LspReferenceWrite = { bg = c.bg_elev },
  NoiceCmdlinePopupBorder = { fg = c.amber },
  NoiceCmdlineIcon = { fg = c.amber },
}

for group, spec in pairs(groups) do
  vim.api.nvim_set_hl(0, group, spec)
end

-- Terminal palette (matches the Zed theme's ANSI colors)
vim.g.terminal_color_0 = "#45475a"
vim.g.terminal_color_1 = "#E19B9B"
vim.g.terminal_color_2 = "#A2E4D2"
vim.g.terminal_color_3 = "#f9e2af"
vim.g.terminal_color_4 = "#89b4fa"
vim.g.terminal_color_5 = "#f5c2e7"
vim.g.terminal_color_6 = "#b4befe"
vim.g.terminal_color_7 = "#cdd6f4"
vim.g.terminal_color_8 = "#a6adc8"
vim.g.terminal_color_9 = "#E19B9B"
vim.g.terminal_color_10 = "#A2E4D2"
vim.g.terminal_color_11 = "#f9e2af"
vim.g.terminal_color_12 = "#89b4fa"
vim.g.terminal_color_13 = "#f5c2e7"
vim.g.terminal_color_14 = "#b4befe"
vim.g.terminal_color_15 = "#bac2de"
