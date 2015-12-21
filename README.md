# profiles
Collection of my program profiles for linux

## .vimrc

This is my vimrc it is completly self managed and automatically installed the plugin manager NeoBundle and all plugins. Only prerequsite is that you have `git` installed on your system.

If you like later on to update the vim plugins enter `:NeoBundleUpdate`.

### Keybindings

Leader keybindings (',')

Keys    | Description
--------|------------
2       | Show Yanks
6       | Toogle numbers (relative\|absolut)
7       | Toogle numbers (on\|off)
8       | Toogle spell language (en\|de)
9       | Toggle spell check (on\|off)
0       | Enter writers mode
s       | Switch between header and source
r       | Replace the current word
k       | Jump to a tag

Other keybindings

Keys        | Description
------------|------------
F2          | Nerdtree
F3          | Tagbar
F4          | vimshell
F5          | Split horizontally
F6          | Split vertically
F7          | Toggle GitGutter
F8          | Toggle paste mode
F9          | Toggle undo list
ctrl-left, ctrl-right, ctrl-down, ctrl-up or ctrl-l, ctrl-h, ctrl-k, ctrl-j | Move between panes
alt-left, alt-right, alt-down, alt-up or alt-l, alt-h, alt-k, alt-j | Resize panes
ctrl-c      | Comment line
ctrl-x      | Uncomment line
TAB         | Move to next buffer
s-TAB       | Move to previous buffer
CR          | Highlight current word
ctrl-p      | Rotate the previous paste forward in yank buffer
ctrl-n      | Rotate the previous paste backward in yank buffer
s\<motion\> | substitute
ss          | substitute line

#### GitGutter Bindings
https://github.com/airblade/vim-gitgutter

You can jump between hunks:
* jump to next hunk (change): ]c
* jump to previous hunk (change): [c.

You can stage or revert an individual hunk when your cursor is in it:
* stage the hunk with \<Leader\>hs or
* revert it with \<Leader\>hr.

## tmux.conf

This is my tmux.conf. To get started you'll need to install the Tmux Plugin Manager:

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After you started tmux press `ctrl+a I` to install all plugins. To update the plugings press `ctrl+a U`.

### Keybindings

The leader key is `ctrl+a`.

Keys        | Description
------------|------------
ctrl+f      | Search for file
n           | Next
N           | Previous
CR          | Copy selected text
]           | Paste

