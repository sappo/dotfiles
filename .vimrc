"""""""""""""
"  PLUGINS  "
"""""""""""""
"" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

"" Install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes


"" Look & Feel
Plug 'powerline/fonts', { 'do' : 'sh install.sh' }

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

Plug 'NLKNguyen/papercolor-theme'

Plug 'rhysd/accelerated-jk'

"" Code Completion
Plug 'Shougo/neosnippet-snippets'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" Text Manipulation
Plug 'tpope/vim-commentary'

Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'

"" Operator extensions
Plug 'kana/vim-textobj-user'
" Adds new text object block `ib` and `ab`
Plug 'rhysd/vim-textobj-anyblock'

Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround'

"" Search 
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }

"" Version Control
Plug 'tpope/vim-fugitive'

Plug 'christoomey/vim-conflicted'
Plug 'chrisbra/vim-diff-enhanced'

" A Vim plugin for more pleasant editing on commit messages
Plug 'rhysd/committia.vim'

"" Writing
Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'text', 'gitcommit', 'gitconfig'] } 

"" Initialize plugin system
call plug#end()

"""""""""""""""""""""
"  PLUGIN SETTINGS  "
"""""""""""""""""""""
"" Look & Feel
""" Powerline fonts 
let font_otf=expand('~/.local/share/fonts/Source Code Pro Medium for Powerline.otf')
if filereadable(font_otf)
  silent !gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Source Code Pro for Powerline Medium 11"
  if has('gui_running')
    set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11
  endif
  let g:airline_powerline_fonts = 1
endif

""" Airline
set laststatus=2

let g:airline_theme='papercolor'
" Don't show seperators
let g:airline#extensions#hunks#enabled=0
" Disable tagbar integration as it might slows vim down
let g:airline#extensions#tagbar#enabled = 0

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

""" PaperColor Theme
set t_Co=256
set background=light
colorscheme PaperColor

""" Accelerated-jk
let g:accelerated_jk_acceleration_limit = 300

nmap <Down> <Plug>(accelerated_jk_gj)
nmap <Up> <Plug>(accelerated_jk_gk)
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"" UI
""" Explorer
nmap <space>e :CocCommand explorer<CR>

"" Code Completion
""" Coc Defaults
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

""" Coc Navigation Mappings
" navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" navigate chunks of current buffer
nmap <silent> [c <Plug>(coc-git-prevchunk)
nmap <silent> ]c <Plug>(coc-git-nextchunk)

""" Coc GoTo Mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" Coc Git Mappings
" show chunk diff at current position
nmap ci <Plug>(coc-git-chunkinfo)
" undo chunk at current position
nmap cu :<C-u>CocCommand git.chunkUndo<cr>
" stage chunk at current position
nmap cs :<C-u>CocCommand git.chunkStage<cr>

""" Coc Other Mappings
" Use <c-space> to trigger completion.
inoremap <expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Use L or Ctrl+L to show signature help in preview window.
nmap <silent> <L> :call CocActionAsync('showSignatureHelp')<CR>
imap <silent> <C-l> <ESC>:call CocActionAsync('showSignatureHelp')<CR>a

" $ccls/member
" member variables / variables in a namespace
nn <silent> xm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""" Coc List Mappings
" Show all diagnostics.
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Show actions
nnoremap <silent> <space>a  :<C-u>CocList actions<cr>
" Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Yank List
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
" Git Status list
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"" Text Manipulation
""" Yoink
set clipboard=unnamedplus

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

""" Subversive
" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

"" Operator Settings
""" Surround mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

" if you use vim-textobj-anyblock
nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-anyblock-a)
nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-anyblock-a)

"" Version Control
""" Fugitive
" Fugitive reference
noremap <silent> <leader>g? :map <leader>g<cr>
" Fugitive mapping
noremap <silent> <leader>gb :Gblame<cr>
noremap <silent> <leader>gw :Gbrowse<cr>
noremap <silent> <leader>gc :Gcommit<cr>
noremap <silent> <leader>gd :Gdiff<cr>
noremap <silent> <leader>gg :Ggrep
noremap <silent> <leader>gl :Glog<cr>
noremap <silent> <leader>gr :Gwrite<cr>
noremap <silent> <leader>gs :Gstatus<cr>

""" Diff
" Started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
if has("patch-8.1.0360")
  set diffopt+=internal,algorithm:patience
endif

""" Commit dialog
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
  " Additional settings
  setlocal spell

  " If no commit message, start with insert mode
  if a:info.vcs ==# 'git' && getline(1) ==# ''
    startinsert
  end

  " Scroll the diff window from insert mode
  imap <buffer><C-f> <Plug>(committia-scroll-diff-down-page)
  imap <buffer><C-b> <Plug>(committia-scroll-diff-up-page)
  imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
  imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)
endfunction

"" Writing
""" vim-grammarous
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
    nmap <buffer><C-r> <Plug>(grammarous-reset)
    nmap <buffer><C-o> <Plug>(grammarous-open-info-window)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><C-f>
    nunmap <buffer><C-r>
    nunmap <buffer><C-o>
endfunction
""""""""""""""""""""""
"  GENERAL SETTINGS  "
""""""""""""""""""""""
"" Defaults
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
set diffopt+=vertical " split vimdiff vertical
set wrap
set linebreak
set mouse=a " Mouse enabled for scrolling, selection, and cursor movement
syntax enable

"" Split, Move & Resize
" Split
set splitbelow
set splitright
nmap <F5> :split<CR>
nmap <F6> :vsplit<CR>

" Move
nmap <c-Left> <c-W><c-h>
nmap <c-Right> <c-W><c-l>
nmap <c-Down> <c-W><c-j>
nmap <c-Up> <c-W><c-k>
nmap <c-h> <c-W><c-h>
nmap <c-l> <c-W><c-l>
nmap <c-j> <c-W><c-j>
nmap <c-k> <c-W><c-k>

" Resize
nmap <a-Left> <c-w><c-<>
nmap <a-Right> <c-w><c->>
nmap <a-Down> <c-w><c-->
nmap <a-Up> <c-w><c-+>
nmap <a-h> <c-w><c-<>
nmap <a-l> <c-w><c->>
nmap <a-j> <c-w><c-->
nmap <a-k> <c-w><c-+>
"" Redirect to blackhole instead of clipboard
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

"" Highlight current word with enter
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

"" Enable Alt-letter for mappings
" Alt-letter will now be recognised by vi in a terminal as well as by gvim. The
" timeout settings are used to work around the ambiguity with escape sequences.
" Esc and j sent within 50ms will be mapped to <A-j>, greater than 50ms will
" count as separate keys. That should be enough time to distinguish between Meta
" encoding and hitting two keys.
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50

"" XTerm Tweaks
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

"" Tmux Tweaks
" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
if exists('$TMUX')
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"" UNDO
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
  set undolevels=50
endif

""""""""""""""""""""""""
"  Autofolding .vimrc  "
""""""""""""""""""""""""
"" " see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
"" defines a foldlevel for each line of code
function! VimFolds(lnum)
  let s:thisline = getline(a:lnum)
  if match(s:thisline, '^"" ') >= 0
    return '>2'
  endif
  if match(s:thisline, '^""" ') >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    endif
  else
    if (match(s:thisline, '^"""""') >= 0) &&
       \ (match(s:line_1_after, '^"  ') >= 0) &&
       \ (match(s:line_2_after, '^""""') >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction

"" defines a foldtext
function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' l)'
  if v:foldlevel == 1
    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = '   ●  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction

"" set foldsettings automatically for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim 
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=VimFolds(v:lnum) |
                   \ setlocal foldtext=VimFoldText() |
     "              \ set foldcolumn=2 foldminlines=2
augroup END

