# dotfiles
Collection of my dotfiles for linux

## .vimrc

This is my vimrc it is completely self managed and automatically installs the plugin manager NeoBundle and all plugins. Only prerequisite is that you have `git` installed on your system. If you like to use autocompletion make sure you're vim has python and lua enabled. For Ubuntu install `vim-nox` if you're running on a headless server and `vim-gnome` on a desktop to enable clipboard support.

To update the plugins enter `:NeoBundleUpdate`.

### Keybindings

Leader keybindings (',')

Keys      | Description
----------|------------
`2`       | Show Yanks
`6`       | Toogle numbers (relative\|absolut)
`7`       | Toogle numbers (on\|off)
`8`       | Toogle spell language (en\|de)
`9`       | Toggle spell check (on\|off)
`0`       | Enter writers mode
`s`       | Switch between header and source
`r`       | Replace the current word
`k`       | Jump to a tag

Other keybindings

To open a menu with useful commands press `ctrl + u` to close the menu press `q`.

Keys          | Description
------------  |------------
`F2`          | Nerdtree
`F3`          | Tagbar
`F4`          | vimshell
`F5`          | Split horizontally
`F6`          | Split vertically
`F7`          | Toggle GitGutter
`F8`          | Toggle paste mode
`F9`          | Toggle undo list
`C-LEFT`, `C-RIGHT`, `C-DOWN`, `C-UP` or `C-l`, `C-h`, `C-k`, `C-j` | Move between panes
`A-LEFT`, `A-RIGHT`, `A-DOWN`, `A-UP` or `A-l`, `A-h`, `A-k`, `A-j` | Resize panes
`C-c`         | Comment line
`C-x`         | Uncomment line
`TAB`         | Move to next buffer
`S-TAB`       | Move to previous buffer
`C-w`         | Close current buffer (does not close the last)
`CR`          | Highlight current word
`C-p`         | Rotate forward in yank buffer
`C-n`         | Rotate backward in yank buffer
`s\<motion\>` | substitute
`ss`          | substitute line
`space-u`     | open the menu
`C-space`     | ctrlspace menu

To compile asynchronously use `:Make` for foreground compilation and `:Make!` for background compilation.

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
`C-f`       | Search for file
`n`         | Next
`N`         | Previous
`CR`        | Copy selected text
`]`         | Paste
`C-,`       | Rename pane
`C-;`       | Rename session
`C-x`       | Kill current pane
`C-X`       | Kill current session
`C-Q`       | Kill tmux server
`\|`        | Split vertically
`-`         | Split horizontally
