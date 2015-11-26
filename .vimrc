if has('vim_starting')
    set nocompatible               " Be iMproved
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" ==============================================================================
" Bundles
" ==============================================================================

" Setting up NeoBundle
let iCanHazNeoBundle=1
let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
  echo "Installing neobundle.vim."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  let iCanHazNeoBundle=0
endif

set rtp+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

filetype plugin indent on     " Required!

" Syntax {{{
" ==========

"NeoBundle 'scrooloose/syntastic'
"if neobundle#tap('syntastic')
  "function! neobundle#hooks.on_source(bundle)
    "let g:syntastic_loc_list_height = 5
    "let g:syntastic_always_populate_loc_list = 1
    "let g:syntastic_auto_loc_list = 1
    "let g:syntastic_check_on_open = 1
    "let g:syntastic_check_on_wq = 0
  "endfunction
  "call neobundle#untap()
"endif

NeoBundle 'benekastah/neomake'
if neobundle#tap('neomake')
  function! neobundle#hooks.on_source(bundle)
    autocmd! BufWritePost * Neomake
    let g:neomake_airline = 1
  endfunction
  call neobundle#untap()
endif
" }}}

" Completion {{{
" ==============

NeoBundle 'Shougo/neocomplete.vim'
if neobundle#tap('neocomplete.vim')
  function! neobundle#hooks.on_source(bundle)
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#loock_buffer_name_pattern = '\*ku\*'

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      " return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

  endfunction
  call neobundle#untap()
endif

NeoBundle 'aklt/vim-simple_comments'
if neobundle#tap('vim-simple_comments')
  function! neobundle#hooks.on_source(bundle)
    let g:simple_comments_Comment = '<c-c>'
    let g:simple_comments_Remove = '<c-x>'
  endfunction
  call neobundle#untap()
endif

NeoBundle 'xolox/vim-easytags'
NeoBundle 'xolox/vim-misc' " dependency for easytags

NeoBundle 'vim-scripts/YankRing.vim'
if neobundle#tap('YankRing.vim')
  function! neobundle#hooks.on_source(bundle)
    let g:yankring_max_history = 5
    let g:yankring_share_between_instances = 1
    let g:yankring_ignore_duplicate = 1
    let g:yankring_default_menu_mode = 3
    let g:yankring_menu_priority = 30
    let g:yankring_history_dir = '$HOME'
    let g:yankring_history_file = '.vim_yankring_history.txt'
  endfunction
  call neobundle#untap()
endif

" }}}

" Searching {{{
" ============

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
if neobundle#tap('vimproc.vim')
  function! neobundle#hooks.on_source(bundle)
  endfunction
  call neobundle#untap()
endif

NeoBundle 'kien/ctrlp.vim'
if neobundle#tap('ctrlp.vim')
  function! neobundle#hooks.on_source(bundle)
    " Setup some default ignores
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
      \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
    \}
    let g:ctrlp_cmd = 'CtrlPMixed'
    let g:ctrlp_open_multiple_files = '1vjr'

    " Map space to the prefix for Unite
    nnoremap [ctrlp] <Nop>
    nmap <space> [ctrlp]

    nnoremap <silent> [ctrlp]<space> :<C-u>CtrlPMixed<CR>
  endfunction
  call neobundle#untap()
endif

NeoBundle 'haya14busa/incsearch.vim'
if neobundle#tap('incsearch.vim')
  function! neobundle#hooks.on_source(bundle)
    map /  <Plug>(incsearch-forward)

    let g:incsearch#auto_nohlsearch = 1
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
  endfunction
  call neobundle#untap()
endif

NeoBundle 'haya14busa/incsearch-fuzzy.vim'
if neobundle#tap('incsearch-fuzzy.vim')
  function! neobundle#hooks.on_source(bundle)
    map z/ <Plug>(incsearch-fuzzy-/)
  endfunction
  call neobundle#untap()
endif

NeoBundle 'vim-scripts/a.vim'
if neobundle#tap('a.vim')
  function! neobundle#hooks.on_source(bundle)

  endfunction
  call neobundle#untap()
endif

" }}}

" Browsing {{{
" ============

" The NERD tree allows you to explore your filesystem.
NeoBundle 'scrooloose/nerdtree'
if neobundle#tap('nerdtree')
function! neobundle#hooks.on_source(bundle)
  let g:NERDTreeDirArrows = 1
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'
endfunction
call neobundle#untap()
endif

" Vim plugin that displays tags in a window, ordered by class etc.
NeoBundle 'majutsushi/tagbar'
if neobundle#tap('tagbar')
function! neobundle#hooks.on_source(bundle)
  let g:tagbar_width = 30
  let g:tagbar_foldlevel = 1
  let g:tagbar_type_rst = {
      \ 'ctagstype': 'rst',
      \ 'kinds': [ 'r:references', 'h:headers' ],
      \ 'sort': 0,
      \ 'sro': '..',
      \ 'kind2scope': { 'h': 'header' },
      \ 'scope2kind': { 'header': 'h' }
      \ }

endfunction
call neobundle#untap()
endif

NeoBundle 'mbbill/undotree'
if neobundle#tap('tagbar')
function! neobundle#hooks.on_source(bundle)
  if has("persistent_undo")
    set undodir=~/.vim_undodir/
    set undofile
  endif
endfunction
call neobundle#untap()
endif


" }}}

" Shell {{{
" ==============================

" Vim plugin required by vimshell
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }
if neobundle#tap('vimproc.vim')
function! neobundle#hooks.on_source(bundle)

endfunction
call neobundle#untap()
endif

" Vim plugin that brings the shell to vim
NeoBundle 'Shougo/vimshell.vim'
if neobundle#tap('vimshell.vim')
function! neobundle#hooks.on_source(bundle)
  let g:vimshell_enable_smart_case   = 1
  let g:vimshell_temporary_directory = "~/tmp/vimshell"
  let g:vimshell_split_command = ''
  let g:vimshell_enable_transient_user_prompt = 1
  let g:vimshell_force_overwrite_statusline = 1

  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_right_prompt = '"[" . getcwd() . "]"'

  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% "
  endif
endfunction
call neobundle#untap()
endif

" }}}

" Version Control {{{
" ==============================

NeoBundle 'tpope/vim-fugitive'

" }}}

" Look & Feel + nice Buffers {{{
" ==============================

NeoBundle 'bling/vim-airline'
if neobundle#tap('vim-airline')
function! neobundle#hooks.on_source(bundle)
  set laststatus=2
  let g:airline_powerline_fonts = 1
  " Don't show seperators
  let g:airline#extensions#hunks#enabled=0

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  " This allows buffers to be hidden if you've modified a buffer.
  " This is almost a must if you wish to use buffers in this way.
  set hidden
  " Move to the next buffer
  nmap <tab> :bnext<CR>
  " Move to the previous buffer
  nmap <s-tab> :bprev<CR>
  " Close the current buffer and move to the previous one
  nmap <s-w> :bp <BAR> bd #<CR>
endfunction
call neobundle#untap()
endif

NeoBundle 'edkolev/tmuxline.vim'
if neobundle#tap('tmuxline.vim')
function! neobundle#hooks.on_source(bundle)
  let g:tmuxline_preset = {
    \'a'    : '#S',
    \'win'  : '#I #W',
    \'cwin' : '#I #W',
    \'x'    : ['%a', '%D'],
    \'y'    : '%R',
    \'z'    : '#H'}
  let g:tmuxline_powerline_separators = 1
endfunction
call neobundle#untap()
endif

NeoBundle 'edkolev/promptline.vim'
if neobundle#tap('promptline.vim')
function! neobundle#hooks.on_source(bundle)
  let g:promptline_theme = 'papercolor'
endfunction
call neobundle#untap()
endif

NeoBundle 'NLKNguyen/papercolor-theme'
if neobundle#tap('papercolor-theme')
function! neobundle#hooks.on_source(bundle)
  set t_Co=256
  colorscheme PaperColor
  let g:airline_theme='papercolor'
endfunction
call neobundle#untap()
endif

" }}}

" Writing {{{
" ==============================

NeoBundle 'junegunn/goyo.vim'
if neobundle#tap('goyo.vim')
function! neobundle#hooks.on_source(bundle)
  let g:goyo_width=90
  let g:goyo_height=90
endfunction
call neobundle#untap()
endif

NeoBundle 'amix/vim-zenroom2'
if neobundle#tap('vim-zenroom2')
function! neobundle#hooks.on_source(bundle)
endfunction
call neobundle#untap()
endif

" }}}

" Optimazation {{{
" ==============================

" Disable plugins for LargeFile
NeoBundleLazy 'vim-scripts/LargeFile'
"
" Find and eliminate trailing whitespaces
NeoBundle 'ntpeters/vim-better-whitespace'
if neobundle#tap('vim-better-whitespace')
function! neobundle#hooks.on_source(bundle)
  autocmd BufWritePre <buffer> StripWhitespace
  let g:better_whitespace_filetypes_blacklist=['<filetype1>', '<filetype2>', '<etc>']
endfunction
call neobundle#untap()
endif

" }}}

call neobundle#end()
" Installation check.
NeoBundleCheck

" ==============================================================================
" Autocommands
" ==============================================================================

" Set augroup
augroup MyAutoCmd
autocmd!
augroup END

" Redraw since vim gets corrupt for no reason
au FocusGained * redraw! " redraw screen on focus

if has("autocmd")
autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
autocmd FileType gitcommit setlocal spell
autocmd FileType gitrebase nnoremap <buffer> S :Cycle<CR>

autocmd FileType html,xhtml,xml,htmldjango,jinja.html,jinja,eruby,mako setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" go support
" ----------
autocmd BufNewFile,BufRead *.go setlocal ft=go
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Java
" ----
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" make support
" ------------
autocmd FileType make setlocal noexpandtab

" cmake support
" -------------
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

" Json
" ----
autocmd FileType json setlocal syntax=javascript

autocmd BufRead,BufNewFile *.adoc,*.asciidoc set syntax=asciidoc
autocmd BufRead,BufNewFile README.txt set syntax=markdown
autocmd BufRead,BufNewFile *.gsl set syntax=c

" Goyo
" ----
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
endif

" ==============================================================================
" Functions
" ==============================================================================

function! NumberRelativeToggle()
if(&relativenumber == 0 && &number == 0)
  echo "Line numbers not enables, use <leader>7 or :set number / :set relativenumber to enable"
elseif(&relativenumber == 1)
  set norelativenumber
else
  set relativenumber
endif
endfunc

function! NumberToggle()
if(&relativenumber == 1)
  set norelativenumber
endif
if(&number == 1)
  set nonumber
else
  set number
endif
endfunc

function! SpellLangToggle()
if(&spelllang == 'en_us')
  set spelllang=de_de
else
  set spelllang=en_us
endif
echo 'spellang is now:' &spelllang
endfunction

function! SpellCheckToggle()
setlocal spell!
if(&spell == 1)
  echo 'spell checking is enabled.'
else
  echo 'spell checking is disabled.'
endif
endfunction

function! s:goyo_enter()
silent !tmux set status off
set noshowmode
set noshowcmd
set scrolloff=999
NeoCompleteDisable
" ...
endfunction

function! s:goyo_leave()
silent !tmux set status on
set showmode
set showcmd
set scrolloff=5
NeoCompleteEnable
" ...
endfunction

" ==============================================================================
" Keymappings
" ==============================================================================

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

nnoremap <silent> <Leader>2 :YRShow<cr>
nnoremap <silent> <Leader>3 :YRClear<cr>
nnoremap <silent> <leader>6 :call NumberRelativeToggle()<CR>
nnoremap <silent> <leader>7 :call NumberToggle()<CR>
nnoremap <silent> <leader>8 :call SpellLangToggle()<CR>
nnoremap <silent> <leader>9 :call SpellCheckToggle()<CR>
nnoremap <silent> <Leader>0 :Goyo<cr>
nnoremap <silent> <Leader>s :A<cr>


" Use CTRL-S for saving, also in Insert mode
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" F-key Bindings
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :TagbarToggle<CR>
nnoremap <silent> <F4> :VimShellPop<CR>
nmap <F5> :split<CR>
nmap <F6> :vsplit<CR>
set pastetoggle=<F8>
nnoremap <F9> :UndotreeToggle<cr>

" Spliting window"
set splitbelow
set splitright
nmap <c-Left> <c-W><c-h>
nmap <c-Right> <c-W><c-l>
nmap <c-Down> <c-W><c-j>
nmap <c-Up> <c-W><c-k>
nmap <c-h> <c-W><c-h>
nmap <c-l> <c-W><c-l>
nmap <c-j> <c-W><c-j>
nmap <c-k> <c-W><c-k>

" Resize window"
nmap <a-Left> <c-w><c-<>
nmap <a-Right> <c-w><c->>
nmap <a-Down> <c-w><c-->
nmap <a-Up> <c-w><c-+>

"  Redo on captital U
nmap <U> :red

" Prepare a substitute command using the current word or the selected text"
nnoremap <c-r> yiw:%s/\<<C-r>"\>/<C-r>"/g<Left><Left><Left>
vnoremap <c-r> y:%s/\<<C-r>"\>/<C-r>"/g<Left><Left><Left>

" Highlight current word with enter"
let g:highlighting = 0
function! Highlighting()
if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
endif
let @/ = '\<'.expand('<cword>').'\>'
let g:highlighting = 1
return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()

" Highlight if a line goes above 80 chars
call matchadd('ColorColumn', '\%81v', 100)
autocmd VimEnter * autocmd WinEnter * let w:colorcolumn=1
autocmd VimEnter * let w:colorcolumn=1
autocmd WinEnter * if !exists('w:colorcolumn') | call matchadd('ColorColumn', '\%81v', 100) | endif

" For wrapped lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" ==============================================================================
" Settings and Defaults
" ==============================================================================

set encoding=utf-8
set fileencoding=utf-8
set backspace=2 " make backspace work like most other apps
set tabstop=4 "tab width in spaces
set shiftwidth=4 "shitwidth in spaces
set cmdheight=1
set expandtab "convert tabs into spaces
set cindent
set number "show line numbers
set hlsearch
set incsearch " incremental searching
syntax enable

" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
" Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
execute "set t_kP=\e[5;*~"
execute "set t_kN=\e[6;*~"
" Arrow keys http://unix.stackexchange.com/a/34723
execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"
endif

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
if exists('$TMUX')
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
