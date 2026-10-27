# Neovim Cheatsheet (for a VSCode brain)

Leader = **Space**. Open this file anytime with **`<leader>?`** (Space then `?`).
Press `<Esc>` to get back to _normal_ mode, then type the keys below.

> Tip: press `<leader>` and wait — **which-key** pops up showing what's available next.

---

## Modes (the #1 VSCode adjustment)

| You want to…                    | Keys                                           |
| ------------------------------- | ---------------------------------------------- |
| Type text (insert mode)         | `i` (or `a`, `o` for new line below)           |
| Stop typing / go to normal mode | `<Esc>`                                        |
| Select text (visual)            | `v` (char), `V` (line), `<C-v>` (block/column) |
| Run a command                   | `:` then command, `<Enter>`                    |

## Files & Search (Telescope)

| VSCode                          | nvim         | Action                              |
| ------------------------------- | ------------ | ----------------------------------- |
| Cmd+P (go to file)              | `<leader>sf` | Find files by name (incl. dotfiles) |
| Cmd+Shift+F (search in project) | `<leader>sg` | Live grep across all files          |
| Search word under cursor        | `<leader>sw` | Grep the current word               |
| Cmd+F (find in file)            | `<leader>/`  | Fuzzy search within current buffer  |
| —                               | `<leader>sr` | Resume last search                  |
| Recent files                    | `<leader>s.` | Recently opened files               |
| Cmd+Shift+P (command palette)   | `<leader>sc` | Search commands                     |
| —                               | `<leader>sk` | Search keymaps (discover bindings!) |
| Help                            | `<leader>sh` | Search Neovim help docs             |
| Edit my config                  | `<leader>sn` | Find files in nvim config           |

## Buffers & Tabs

| VSCode            | nvim               | Action                             |
| ----------------- | ------------------ | ---------------------------------- |
| Next/prev tab     | `<S-l>` / `<S-h>`  | Cycle tabs (Shift+L / Shift+H)     |
| Cmd+W (close tab) | `<leader>x`        | Close current buffer (keeps split) |
| Open tabs list    | `<leader><leader>` | Pick from open buffers             |

## File Explorer (neo-tree)

| VSCode                 | nvim              | Action                                  |
| ---------------------- | ----------------- | --------------------------------------- |
| Cmd+B (toggle sidebar) | `<leader>e`       | Toggle file explorer                    |
| Reveal current file    | `\`               | Open tree focused on current file       |
| Move focus into tree   | `<C-h>`           | Then `j`/`k` to move, `<Enter>` to open |
| Tree help              | `?` (inside tree) | All neo-tree keys                       |

## Windows / Splits

| VSCode             | nvim                 | Action                          |
| ------------------ | -------------------- | ------------------------------- |
| Split editor       | `:vsplit` / `:split` | Vertical / horizontal split     |
| Move between panes | `<C-h/j/k/l>`        | Focus left/down/up/right window |
| Cycle windows      | `<C-w>w`             | Next window                     |

## Editing

| VSCode                      | nvim                                  | Action                                        |
| --------------------------- | ------------------------------------- | --------------------------------------------- |
| Save                        | `:w`                                  | Write file (`:wa` = all)                      |
| Quit                        | `:q`                                  | Close window (`:qa` = all, `:wq` = save+quit) |
| Undo / Redo                 | `u` / `<C-r>`                         |                                               |
| Copy / Paste                | `y` / `p`                             | Uses system clipboard (yank then paste)       |
| Cut line                    | `dd`                                  | Delete (cuts) a line; `yy` copies a line      |
| Comment toggle              | `gcc` (line), `gc` (visual selection) |                                               |
| Indent                      | `>>` / `<<` , or `>`/`<` in visual    |                                               |
| Go to line N                | `:N` or `NG`                          | e.g. `:42`                                    |
| Select all                  | `ggVG`                                | Top, visual-line, bottom                      |
| Surround add/delete/replace | `sa`/`sd`/`sr` (mini.surround)        | e.g. `saiw"` wraps word in quotes             |

## Search & Replace

| VSCode                | nvim                 | Action                   |
| --------------------- | -------------------- | ------------------------ |
| Find in file          | `/text` then `n`/`N` | Next / previous match    |
| Clear highlights      | `<Esc>`              |                          |
| Find & replace (file) | `:%s/old/new/g`      | Live preview as you type |
| Replace with confirm  | `:%s/old/new/gc`     | Confirm each             |

## Code / LSP

| VSCode                         | nvim         | Action                                          |
| ------------------------------ | ------------ | ----------------------------------------------- |
| Hover docs                     | `K`          | Show type/docs popup                            |
| Go to definition               | `grd`        | (`<C-o>` to jump back)                          |
| Go to references               | `grr`        | Find all references                             |
| Go to implementation           | `gri`        |                                                 |
| Type definition                | `grt`        |                                                 |
| Rename symbol (F2)             | `grn`        | Rename across files                             |
| Quick fix / code action        | `gra`        |                                                 |
| Document symbols (Cmd+Shift+O) | `gO`         | Symbols in file                                 |
| Workspace symbols              | `gW`         | Symbols across project                          |
| Format document                | `<leader>f`  | Prettier / formatter                            |
| ESLint fix all                 | `<leader>le` | (in eslint projects)                            |
| Problems panel                 | `<leader>sd` | Search diagnostics; `<leader>q` = quickfix list |
| Next/prev problem              | `]d` / `[d`  | Jump between diagnostics                        |
| Toggle inlay hints             | `<leader>th` |                                                 |

## Git

VSCode Source Control panel equivalents:

| VSCode                  | nvim         | Action                                          |
| ----------------------- | ------------ | ----------------------------------------------- |
| Source Control panel    | `<leader>gg` | Neogit: stage/unstage, commit, push/pull        |
| See all changes (diff)  | `<leader>gd` | Diffview: changed-files list + side-by-side diff |
| File history / timeline | `<leader>gf` | Diffview: history of current file               |
| Close diff view         | `<leader>gc` | Close Diffview                                   |

Inline per-hunk while editing (gitsigns):

| Keys                        | Action                                       |
| --------------------------- | -------------------------------------------- |
| `]c` / `[c`                 | Jump to next / previous change               |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (also works in visual)    |
| `<leader>hp`                | Preview hunk diff                            |
| `<leader>hb`                | Blame current line                           |
| `<leader>hd`                | Diff this file against index                 |
| `<leader>tb`                | Toggle inline line-blame                     |

## Handy

| Keys           | Action                                               |
| -------------- | ---------------------------------------------------- |
| `<leader>?`    | Open this cheatsheet                                 |
| `<leader>sk`   | Search all keymaps                                   |
| `:Tutor`       | 30-min interactive Vim tutorial (highly recommended) |
| `:checkhealth` | Diagnose config/plugin issues                        |
| `:Mason`       | Manage LSP servers / formatters                      |
