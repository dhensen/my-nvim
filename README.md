# neovim

## install

```
mv ~/.config/nvim ~/.config/nvim-backup
git clone https://github.com/dhensen/my-nvim.git ~/.config/nvim
# or
git clone git@github.com:dhensen/my-nvim.git ~/.config/nvim

nvim
```

The first line backs up your existing neovim config if you have one. Opening nvim will bootstrap Lazy and install all plugins.

After install, run `:Lazy update` to pull the latest plugin versions (including harpoon v2).

---

## keybindings

> `<leader>` is `Space`. `<space>` in LSP bindings also means Space (set without leader).
> Most `<leader>` groups are discoverable via **which-key** — just press `Space` and wait.

### files & navigation

| Key | Action |
|-----|--------|
| `<leader>n` | Toggle file tree (nvim-tree) |
| `<leader>j` | Reveal current file in tree |
| `gF` | Open parent folder in system file browser (in tree) |
| `<C-p>` | Telescope: git files (includes untracked) |
| `<leader>ff` | Telescope: find files |
| `<leader>fb` | Telescope: open buffers |
| `<leader>fg` | Telescope: live grep |
| `<leader>fw` | Telescope: grep word under cursor |
| `<leader>fs` | Telescope: grep with custom input |
| `<leader>fh` | Telescope: help tags |
| `<leader>fk` | Telescope: keymaps |
| `<C-h/j/k/l>` | Navigate panes (vim + tmux aware) |
| Arrow keys | Resize current pane |

### harpoon

| Key | Action |
|-----|--------|
| `<C-e>` | Toggle quick menu |
| `<C-e>a` | Mark current file |
| `<C-e>1/2/3` | Jump to mark 1/2/3 |
| `<C-e>n/p` | Next / previous mark |

### editing

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | n/v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system clipboard |
| `<leader>d` | n/v | Delete to black hole register |
| `<leader>cp` | n | Paste from system clipboard (after) |
| `<leader>cP` | n | Paste from system clipboard (before) |
| `<leader>p` | x | Delete selection, paste from clipboard before cursor |
| `<leader>P` | x | Delete selection, paste from clipboard after cursor |
| `K` | x | Move selection up |
| `J` | x | Move selection down |
| `<` / `>` | v | Indent / dedent (stays in visual) |
| `jk` | i/t | Escape |
| `<ESC>` | n | Clear search highlight |
| `Q` | n | (disabled — prevents accidental ex mode) |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gw` | Go to definition in vertical split |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` / `<space>rr` | References |
| `K` | Hover documentation |
| `<space>k` | Signature help |
| `<space>rn` | Rename symbol |
| `<space>ca` | Code action |
| `<space>f` | Format buffer |
| `<space>D` | Go to type definition |
| `<space>ws` | Workspace symbols |
| `<space>wa/wr/wl` | Add / remove / list workspace folders |
| `<space>a` | Open diagnostics float |
| `[d` / `]d` | Previous / next diagnostic |
| `<space>q` | Send diagnostics to loclist |
| `<leader>ii` | Toggle inline diagnostic virtual text |
| `<leader>id` | Toggle all diagnostics |

**Active LSP servers:** pyright, ruff (Python), lua_ls, ts_ls (TypeScript), terraformls

**Formatters (null-ls):** stylua, prettier, terraform_fmt, djlint

**Diagnostics (null-ls):** mypy, yamllint

### git

| Key | Action |
|-----|--------|
| `<leader>gs` | Fugitive status |
| `<leader>gc` | Commit |
| `<leader>gp` | Push |
| `<leader>ga` | `git add -p` (interactive hunk staging) |
| `<leader>gb` | Blame |
| `<leader>gl` | Load all revisions into quickfix |
| `<leader>gj/gk` | Next / previous hunk (gitsigns) |
| `<leader>gg` | Open LazyGit float (snacks) |
| `<leader>gB` | Open current file/line in browser — GitHub, GitLab, etc (snacks) |

### search & replace — grug-far (`<leader>S`)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>So` | n | Open grug-far |
| `<leader>Sw` | n | Search word under cursor |
| `<leader>Sf` | n | Search scoped to current file |
| `<leader>Sv` | v | Search with visual selection |

### testing

| Key | Action |
|-----|--------|
| `<leader>r` | Run nearest test |
| `<leader>o` | Open test output |
| `<leader>s` | Toggle test summary |
| `<space>cc` | Show coverage |
| `<space>ct` | Toggle coverage highlights |

### debugging — DAP (`<leader>D`)

**F-keys** (tight loop):

| Key | Action |
|-----|--------|
| `F5` | Continue / start session |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |

**`<leader>D` group:**

| Key | Action |
|-----|--------|
| `<leader>Dc` | Continue / start |
| `<leader>Dr` | Restart |
| `<leader>Dq` | Terminate |
| `<leader>Dn` | Step over |
| `<leader>Di` | Step into |
| `<leader>Do` | Step out |
| `<leader>Dj` | Step back |
| `<leader>Dh` | Run to cursor |
| `<leader>Db` | Toggle breakpoint |
| `<leader>DB` | Conditional breakpoint (prompts) |
| `<leader>Dl` | Log point (prompts) |
| `<leader>Dx` | Clear all breakpoints |
| `<leader>D?` | List breakpoints → quickfix |
| `<leader>Du` | Toggle DAP UI |
| `<leader>De` | Evaluate expression under cursor |
| `<leader>Dpm` | Debug Python test method |
| `<leader>DpM` | Debug Python test class |
| `<leader>Dps` (visual) | Debug Python selection |

The DAP UI opens automatically when a session starts and closes when it ends.

### trouble

| Key | Action |
|-----|--------|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>R` | LSP definitions / references |

### tools

| Key | Action |
|-----|--------|
| `<leader>t` | Toggle terminal |
| `<leader>u` | Toggle undo tree |
| `<leader>z` | Toggle zen mode |
| `<leader>e` | Run current file (code_runner) |
| `<leader>ln` | Toggle relative line numbers |
| `<leader>bd` | Delete buffer (without closing window) |
| `<leader>.` | Open scratch buffer |
| `<leader>dd` | Hatch a duck 🦆 |
| `<leader>dk` | Cook the duck 🍳 |

### pomodoro

| Command | Action |
|---------|--------|
| `:StartPomodoro` | Start 25-min timer (shows in statusline, enables macOS Focus) |
| `:StopPomodoro` | Stop timer |

---

## issues

- After moving from packer to Lazy, TSUpdate runs on every restart. Run `:checkhealth` and search for `packer`, remove leftover dirs/files.
