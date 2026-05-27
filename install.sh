#!/usr/bin/env sh
# Tagore installer — POSIX-compatible (works in bash, dash, zsh, ash).
# Installs SKILL.md into every detected agentic-CLI skills directory.
#
# Usage:
#   ./install.sh                  # auto-detect and install to every detected harness
#   ./install.sh --all            # install to every supported harness whether detected or not
#   ./install.sh --platform NAME  # install to one harness only
#   ./install.sh --dry-run        # show what would happen, change nothing
#   ./install.sh --uninstall      # remove tagore from every detected harness
#
# Supported --platform values:
#   claude    OpenCode  copilot   codex   gemini   goose   hermes   agents (universal)
#
# After install, a universal symlink is dropped at ~/.agents/skills/tagore so
# that any agent honoring the cross-tool convention picks it up automatically.

set -eu

SKILL_NAME="tagore"
REPO_RAW="https://raw.githubusercontent.com/apurvrdx1/tagore/main"

# Resolve script directory (works for piped curl|bash too: falls back to /tmp clone)
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE-}" ]; then
  # shellcheck disable=SC2128
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" 2>/dev/null && pwd || true)"
elif [ -f "$0" ]; then
  SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"
fi

MODE="auto"
PLATFORM=""
DRY_RUN=0

# ---- Argument parsing -------------------------------------------------------

while [ $# -gt 0 ]; do
  case "$1" in
    --all) MODE="all" ;;
    --platform)
      shift
      PLATFORM="${1:-}"
      MODE="single"
      ;;
    --platform=*)
      PLATFORM="${1#*=}"
      MODE="single"
      ;;
    --dry-run) DRY_RUN=1 ;;
    --uninstall) MODE="uninstall" ;;
    -h|--help)
      sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      exit 2
      ;;
  esac
  shift
done

# ---- Logging helpers --------------------------------------------------------

info()  { printf '  %s\n' "$1"; }
ok()    { printf '✓ %s\n' "$1"; }
skip()  { printf '· %s\n' "$1"; }
warn()  { printf '! %s\n' "$1" >&2; }
fatal() { printf '✗ %s\n' "$1" >&2; exit 1; }

# ---- Source resolution ------------------------------------------------------
# If install.sh was run from inside a clone, copy the local SKILL.md.
# If it was piped from curl, fetch SKILL.md from the published repo into a temp dir.

resolve_source() {
  if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ]; then
    SOURCE_SKILL="$SCRIPT_DIR/SKILL.md"
    info "Using local SKILL.md at $SOURCE_SKILL"
  else
    TMP_DIR="$(mktemp -d)"
    info "Downloading SKILL.md from $REPO_RAW/SKILL.md"
    if command -v curl >/dev/null 2>&1; then
      curl -fsSL "$REPO_RAW/SKILL.md" -o "$TMP_DIR/SKILL.md"
    elif command -v wget >/dev/null 2>&1; then
      wget -q "$REPO_RAW/SKILL.md" -O "$TMP_DIR/SKILL.md"
    else
      fatal "Neither curl nor wget is available. Install one, or clone the repo manually."
    fi
    SOURCE_SKILL="$TMP_DIR/SKILL.md"
  fi
}

# ---- Harness detection ------------------------------------------------------
# Each harness gets:
#   <name>_DIR   the global skills directory (relative to $HOME)
#   <name>_HINT  a sentinel file/directory whose presence implies the harness is installed

# claude:    ~/.claude              ; install to ~/.claude/skills/tagore
# opencode:  ~/.config/opencode     ; install to ~/.config/opencode/skills/tagore
# copilot:   ~/.copilot OR `gh` CLI ; install to ~/.copilot/skills/tagore
# codex:     ~/.codex               ; install to ~/.codex/skills/tagore
# gemini:    ~/.gemini              ; install to ~/.gemini/skills/tagore
# goose:     ~/.config/goose        ; install to ~/.config/goose/skills/tagore
# hermes:    ~/.hermes              ; install to ~/.hermes/skills/writing/tagore
#                                     (Hermes scans skills as <category>/<name>/SKILL.md)
# agents:    universal              ; install/symlink to ~/.agents/skills/tagore

PLATFORMS="claude opencode copilot codex gemini goose hermes agents"

target_for() {
  case "$1" in
    claude)   printf '%s/.claude/skills/%s' "$HOME" "$SKILL_NAME" ;;
    opencode) printf '%s/.config/opencode/skills/%s' "$HOME" "$SKILL_NAME" ;;
    copilot)  printf '%s/.copilot/skills/%s' "$HOME" "$SKILL_NAME" ;;
    codex)    printf '%s/.codex/skills/%s' "$HOME" "$SKILL_NAME" ;;
    gemini)   printf '%s/.gemini/skills/%s' "$HOME" "$SKILL_NAME" ;;
    goose)    printf '%s/.config/goose/skills/%s' "$HOME" "$SKILL_NAME" ;;
    # Hermes (NousResearch/hermes-agent) scans skill directories as
    # <category>/<name>/SKILL.md — so we install under a `writing/` category
    # rather than directly under skills/. The HERMES_HOME env var overrides
    # the default ~/.hermes location when set (e.g. /paperclip/.hermes in
    # containerized Hermes deployments).
    hermes)   printf '%s/skills/writing/%s' "${HERMES_HOME:-$HOME/.hermes}" "$SKILL_NAME" ;;
    agents)   printf '%s/.agents/skills/%s' "$HOME" "$SKILL_NAME" ;;
    *) return 1 ;;
  esac
}

is_detected() {
  case "$1" in
    claude)   [ -d "$HOME/.claude" ] ;;
    opencode) [ -d "$HOME/.config/opencode" ] || command -v opencode >/dev/null 2>&1 ;;
    copilot)  [ -d "$HOME/.copilot" ] || command -v copilot >/dev/null 2>&1 ;;
    codex)    [ -d "$HOME/.codex" ] || command -v codex >/dev/null 2>&1 ;;
    gemini)   [ -d "$HOME/.gemini" ] || command -v gemini >/dev/null 2>&1 ;;
    goose)    [ -d "$HOME/.config/goose" ] || command -v goose >/dev/null 2>&1 ;;
    hermes)   [ -d "${HERMES_HOME:-$HOME/.hermes}" ] || command -v hermes >/dev/null 2>&1 ;;
    agents)   true ;; # always available — universal fallback
    *) return 1 ;;
  esac
}

# ---- Install / uninstall actions -------------------------------------------

install_one() {
  platform="$1"
  target="$(target_for "$platform")" || { warn "Unknown platform: $platform"; return 1; }
  parent="$(dirname "$target")"

  if [ "$DRY_RUN" -eq 1 ]; then
    info "[dry-run] would create $target/SKILL.md"
    return 0
  fi

  mkdir -p "$parent"

  # Universal "agents" path: prefer a symlink to the canonical claude install
  # so editing the source updates everywhere.
  if [ "$platform" = "agents" ] && [ -e "$HOME/.claude/skills/$SKILL_NAME/SKILL.md" ]; then
    rm -rf "$target"
    ln -s "$HOME/.claude/skills/$SKILL_NAME" "$target"
    ok "Linked agents → ~/.claude/skills/$SKILL_NAME"
    return 0
  fi

  mkdir -p "$target"
  cp "$SOURCE_SKILL" "$target/SKILL.md"
  ok "Installed $platform → $target/SKILL.md"
}

uninstall_one() {
  platform="$1"
  target="$(target_for "$platform")" || return 1
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$DRY_RUN" -eq 1 ]; then
      info "[dry-run] would remove $target"
    else
      rm -rf "$target"
      ok "Removed $platform ($target)"
    fi
  else
    skip "$platform not installed"
  fi
}

# ---- Main dispatch ----------------------------------------------------------

if [ "$MODE" = "uninstall" ]; then
  printf 'Uninstalling tagore...\n'
  for p in $PLATFORMS; do
    uninstall_one "$p"
  done
  exit 0
fi

resolve_source

case "$MODE" in
  single)
    if [ -z "$PLATFORM" ]; then fatal "--platform requires a value"; fi
    install_one "$PLATFORM"
    ;;
  all)
    printf 'Installing tagore to every supported harness...\n'
    for p in $PLATFORMS; do
      install_one "$p"
    done
    ;;
  auto)
    printf 'Auto-detecting installed harnesses...\n'
    any=0
    # Skip "agents" inside the loop; it's installed unconditionally at the end
    # as the universal cross-tool fallback.
    for p in $PLATFORMS; do
      [ "$p" = "agents" ] && continue
      if is_detected "$p"; then
        install_one "$p"
        any=1
      else
        skip "$p not detected"
      fi
    done
    if [ "$any" -eq 0 ]; then
      warn "No supported harness detected. Run with --all to install everywhere, or --platform NAME for one."
      exit 1
    fi
    install_one "agents"
    ;;
esac

printf '\nDone. Restart your CLI or run its skill-reload command to pick up the new skill.\n'
