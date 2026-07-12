#!/usr/bin/env bash
# bootstrap.sh — install everything this Neovim setup needs, then wire it up.
#
# Fresh-machine flow:
#   1) install git if missing        (e.g. sudo apt install -y git)
#   2) git clone <your dotfiles repo> ~/dotfiles
#   3) ~/dotfiles/nvim/bootstrap.sh
#   4) open `nvim`  →  everything is installed and themed
#
# Or clone-less:  DOTFILES_REPO=git@github.com:you/dotfiles.git bash bootstrap.sh
#
# Supports macOS (Homebrew) and Linux (apt / dnf / pacman / zypper), incl. WSL.
# Idempotent — safe to re-run. Optional extras via flags:
#   --with-rust      install the rustup toolchain (Rust editing)
#   --with-zellij    install zellij
#   --with-claude    install the Claude Code CLI (for claudecode.nvim)
#   --no-font        skip the Nerd Font download
#   --no-bootstrap   skip the headless plugin install at the end
set -u

# make ~/.local/bin usable within this run (some tools install there)
export PATH="$HOME/.local/bin:$PATH"

c_info(){ printf '\033[1;34m::\033[0m %s\n' "$*"; }
c_ok(){   printf '\033[1;32m ✓ \033[0m%s\n' "$*"; }
c_warn(){ printf '\033[1;33m ! \033[0m%s\n' "$*"; }
c_err(){  printf '\033[1;31m ✗ \033[0m%s\n' "$*" >&2; }
have(){ command -v "$1" >/dev/null 2>&1; }

# ---------- flags ----------
WITH_RUST=0; WITH_ZELLIJ=0; WITH_CLAUDE=0; DO_FONT=1; DO_BOOTSTRAP=1
for a in "$@"; do
  case "$a" in
    --with-rust) WITH_RUST=1 ;;
    --with-zellij) WITH_ZELLIJ=1 ;;
    --with-claude) WITH_CLAUDE=1 ;;
    --no-font) DO_FONT=0 ;;
    --no-bootstrap) DO_BOOTSTRAP=0 ;;
    *) c_warn "ignoring unknown flag: $a" ;;
  esac
done

# ---------- sudo ----------
SUDO=""
if [ "$(id -u)" -ne 0 ] && have sudo; then SUDO="sudo"; fi

# ---------- detect OS / package manager ----------
OS="$(uname -s)"; ARCH="$(uname -m)"; PM=""
case "$OS" in
  Darwin) PM="brew" ;;
  Linux) for m in apt-get dnf pacman zypper; do have "$m" && { PM="$m"; break; }; done ;;
esac
[ -n "$PM" ] || { c_err "No supported package manager found. Install deps manually (see nvim/README.md §1)."; exit 1; }
c_info "OS=$OS  package-manager=$PM  arch=$ARCH"

# ---------- Homebrew (macOS) ----------
if [ "$PM" = "brew" ] && ! have brew; then
  c_info "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  [ -x /usr/local/bin/brew ]   && eval "$(/usr/local/bin/brew shellenv)"
fi

pm_install(){
  case "$PM" in
    apt-get) $SUDO apt-get install -y "$@" ;;
    dnf)     $SUDO dnf install -y "$@" ;;
    pacman)  $SUDO pacman -S --noconfirm --needed "$@" ;;
    zypper)  $SUDO zypper install -y "$@" ;;
    brew)    brew install "$@" ;;
  esac
}

# ---------- refresh indexes ----------
c_info "Refreshing package lists…"
case "$PM" in
  apt-get) $SUDO apt-get update -y ;;
  pacman)  $SUDO pacman -Sy --noconfirm ;;
  zypper)  $SUDO zypper refresh ;;
  brew)    brew update || true ;;
esac

# ---------- core dependencies ----------
c_info "Installing core dependencies (git, compiler, node, ripgrep, fd, unzip)…"
case "$PM" in
  apt-get) pm_install git build-essential unzip curl ripgrep fd-find nodejs npm ;;
  dnf)     pm_install git make gcc gcc-c++ unzip curl ripgrep fd-find nodejs npm ;;
  pacman)  pm_install git base-devel unzip curl ripgrep fd nodejs npm ;;
  zypper)  pm_install git make gcc gcc-c++ unzip curl ripgrep fd nodejs npm ;;
  brew)    pm_install git ripgrep fd node
           xcode-select -p >/dev/null 2>&1 || xcode-select --install || true ;;
esac

# fd is 'fdfind' on Debian/Ubuntu — add a shim
if ! have fd && have fdfind; then
  mkdir -p "$HOME/.local/bin"; ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  c_ok "linked fd -> fdfind (~/.local/bin)"
fi

# node sanity
if have node; then
  nv="$(node -v 2>/dev/null)"; c_ok "node $nv"
  case "$nv" in v1[0-7].*|v[1-9].*) c_warn "node $nv is old; LSPs want >=18. Consider nvm/fnm." ;; esac
else
  c_warn "node not found — Vue/JS LSPs and Copilot need it."
fi

# ---------- Neovim (>= 0.11) ----------
install_nvim_tarball(){
  local asset
  case "$ARCH" in
    x86_64|amd64) asset="nvim-linux-x86_64" ;;
    aarch64|arm64) asset="nvim-linux-arm64" ;;
    *) c_warn "unknown arch $ARCH; trying package manager"; pm_install neovim; return ;;
  esac
  c_info "Downloading Neovim ($asset) from the official GitHub release…"
  curl -fL "https://github.com/neovim/neovim/releases/latest/download/${asset}.tar.gz" -o /tmp/nvim.tar.gz \
    || { c_err "Neovim download failed"; return 1; }
  mkdir -p "$HOME/.local"; rm -rf "$HOME/.local/${asset}"
  tar -C "$HOME/.local" -xzf /tmp/nvim.tar.gz
  mkdir -p "$HOME/.local/bin"; ln -sf "$HOME/.local/${asset}/bin/nvim" "$HOME/.local/bin/nvim"
  c_ok "Neovim installed to ~/.local/${asset}"
}
nvim_ok(){ have nvim && nvim --headless -c 'lua os.exit(vim.fn.has("nvim-0.11")==1 and 0 or 1)' >/dev/null 2>&1; }
if nvim_ok; then
  c_ok "Neovim OK ($(nvim --version | head -1))"
else
  c_info "Installing Neovim >= 0.11…"
  if [ "$PM" = "brew" ]; then pm_install neovim; else install_nvim_tarball; fi
  nvim_ok && c_ok "Neovim ready ($(nvim --version | head -1))" || c_warn "Neovim may be too old; check 'nvim --version'."
fi

# ---------- lazygit (optional but nice: <leader>gg) ----------
if ! have lazygit; then
  c_info "Installing lazygit…"
  case "$PM" in
    brew) pm_install lazygit || true ;;
    pacman) pm_install lazygit || true ;;
    dnf) $SUDO dnf copr enable atim/lazygit -y >/dev/null 2>&1; pm_install lazygit || true ;;
    *) # apt/zypper usually lack it — grab the release binary (Linux x86_64/arm64)
       lg_ver="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -oP '"tag_name": *"v\K[^"]+' || true)"
       lg_arch="x86_64"; [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ] && lg_arch="arm64"
       if [ -n "$lg_ver" ]; then
         curl -fL "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lg_ver}_Linux_${lg_arch}.tar.gz" -o /tmp/lazygit.tar.gz \
           && tar -C /tmp -xzf /tmp/lazygit.tar.gz lazygit \
           && install -Dm755 /tmp/lazygit "$HOME/.local/bin/lazygit" \
           && c_ok "lazygit $lg_ver -> ~/.local/bin" || c_warn "lazygit auto-install failed (optional)."
       fi ;;
  esac
fi

# ---------- optional extras ----------
if [ "$WITH_RUST" = 1 ] && ! have cargo; then
  c_info "Installing Rust (rustup)…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || c_warn "rustup failed"
fi
if [ "$WITH_ZELLIJ" = 1 ] && ! have zellij; then
  c_info "Installing zellij…"
  case "$PM" in brew|pacman) pm_install zellij || true ;; *) have cargo && cargo install zellij || c_warn "install zellij manually" ;; esac
fi
if [ "$WITH_CLAUDE" = 1 ] && ! have claude; then
  c_info "Installing Claude Code CLI…"
  if have npm; then npm install -g @anthropic-ai/claude-code || c_warn "claude install failed — see docs.claude.com"; fi
fi

# ---------- Nerd Font ----------
if [ "$DO_FONT" = 1 ]; then
  if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd"; then
    c_ok "Nerd Font already installed"
  else
    c_info "Installing JetBrainsMono Nerd Font…"
    case "$OS" in Darwin) fdir="$HOME/Library/Fonts" ;; *) fdir="$HOME/.local/share/fonts" ;; esac
    mkdir -p "$fdir"
    if curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" -o /tmp/JBMono.zip \
        && unzip -o /tmp/JBMono.zip -d "$fdir" >/dev/null 2>&1; then
      have fc-cache && fc-cache -f "$fdir" >/dev/null 2>&1
      c_ok "Installed to $fdir"
      c_warn "SELECT 'JetBrainsMono Nerd Font' in your terminal app for icons to render."
    else
      c_warn "Font install failed — grab one from nerdfonts.com and set it in your terminal."
    fi
  fi
fi

# ---------- locate config + symlink ----------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
NVIM_SRC="$SCRIPT_DIR"
if [ ! -f "$NVIM_SRC/init.lua" ]; then
  if [ -n "${DOTFILES_REPO:-}" ]; then
    c_info "Cloning $DOTFILES_REPO -> ~/dotfiles…"
    [ -d "$HOME/dotfiles" ] || git clone "$DOTFILES_REPO" "$HOME/dotfiles"
    NVIM_SRC="$HOME/dotfiles/nvim"
  fi
fi
[ -f "$NVIM_SRC/init.lua" ] || { c_err "Can't find the nvim config (no init.lua). Set DOTFILES_REPO or run me from inside the repo."; exit 1; }

CFG="$HOME/.config/nvim"
mkdir -p "$HOME/.config"
if [ -e "$CFG" ] && [ ! -L "$CFG" ]; then
  mv "$CFG" "$CFG.bak.$(date +%s)"; c_warn "backed up existing $CFG"
fi
ln -sfn "$NVIM_SRC" "$CFG"
c_ok "linked $CFG -> $NVIM_SRC"

# ---------- install plugins ----------
if [ "$DO_BOOTSTRAP" = 1 ] && have nvim; then
  c_info "Installing plugins (headless — this may take a minute)…"
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || c_warn "Lazy sync hit a snag; open nvim and check :Lazy"
  c_ok "Plugins installed"
fi

# ---------- summary ----------
echo
c_ok "Bootstrap complete."
echo "Next:"
echo "  • Ensure ~/.local/bin is on your PATH (add to ~/.zshrc or ~/.bashrc if not)."
echo "  • Open nvim; let Mason finish installing the LSP servers (~1-2 min)."
echo "  • Run :Copilot auth  (Copilot ghost-text)."
have claude && echo "  • Run 'claude' and /login if the CLI isn't authenticated yet."
echo "  • Select a Nerd Font in your terminal if you haven't."
