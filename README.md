# profiles
Collection of my program profiles for linux

## .vimrc

This is my vimrc which will automatically install NeoBundle and afterwards automatically install all plugins.

### Keybindings

Leader keybindings (',')

Keys    | Description
--------|------------
2       | Show YankRing
3       | Clear YankRing
6       | Toogle numbers (relative\|absolut)
7       | Toogle numbers (on\|off)
8       | Toogle spell language (en\|de)
9       | Toggle spell check (on\|off)
0       | Enter writers mode
s       | Switch between header and source
r       | Replace the current word
k       | Jump to a tag

Other keybindings

Keys    | Description
--------|------------
F2      | Nerdtree
F3      | Tagbar
F4      | vimshell
F5      | Split horizontally
F6      | Split vertically
F7      | Toggle GitGutter
F8      | Toggle paste mode
F9      | Toggle undo list
c-left, c-right, c-down, c-up or c-l, c-h, c-k, c-j | Move between panes
a-left, a-right, a-down, a-up or a-l, a-h, a-k, a-j | Resize panes
c-c     | Comment line
c-x     | Uncomment line
TAB     | Move to next buffer
s-TAB   | Move to previous buffer
c-r     | Replace the current word or selected text
CR      | Highlight current word

#### GitGutter Bindings
https://github.com/airblade/vim-gitgutter

You can jump between hunks:
* jump to next hunk (change): ]c
* jump to previous hunk (change): [c.

You can stage or revert an individual hunk when your cursor is in it:
* stage the hunk with <Leader>hs or
* revert it with <Leader>hr.
