if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
else
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

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

NeoBundle 'benekastah/neomake'
if neobundle#tap('neomake')
  function! neobundle#hooks.on_source(bundle)
    autocmd! BufNewFile,BufWritePost * Neomake
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
    " Larger cache limit so all tag files are read into cache
    let g:neocomplete#sources#tags#cache_limit_size = 5000000
    let g:neocomplete#data_directory = expand('~/.vim/neocomplete')

    " filetype text
    if !exists('g:neocomplete#text_mode_filetypes')
        let g:neocomplete#text_mode_filetypes = {}
    endif
    let g:neocomplete#text_mode_filetypes = {
                \ 'nothing': 1,
                \ 'rst': 1,
                \ 'markdown': 1,
                \ 'gitrebase': 1,
                \ 'gitcommit': 1,
                \ 'hybrid': 1,
                \ 'text': 1,
                \ 'shd': 0,
                \ 'help': 1,
                \ 'changelog': 0,
                \ 'php': '',
                \ 'vim': 1,
                \ 'tex': 1,
                \ }

    if !exists('g:neocomplete#delimiter_patterns')
      let g:neocomplete#delimiter_patterns= {}
    endif
    let g:neocomplete#delimiter_patterns.vim = ['#']
    let g:neocomplete#delimiter_patterns.cpp = ['::']
    let g:neocomplete#delimiter_patterns.c = ['.', '->']

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

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Disable automatic completion in gitcommit
    autocmd FileType gitcommit NeoCompleteLock
  endfunction
  call neobundle#untap()
endif

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
if neobundle#tap('neosnippet-snippets')
  function! neobundle#hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets' behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif
  endfunction
  call neobundle#untap()
endif

NeoBundle 'rhysd/github-complete.vim'
if neobundle#tap('github-complete.vim')
  function! neobundle#hooks.on_source(bundle)
    " Disable overwriting 'omnifunc'
    let g:github_complete_enable_omni_completion = 0
    " <C-x><C-x> invokes completions of github-complete.vim
    autocmd FileType markdown,gitcommit
    \ imap <C-x><C-x> <Plug>(github-complete-manual-completion)
  endfunction
  call neobundle#untap()
endif

NeoBundle 'ludovicchabant/vim-gutentags'
if neobundle#tap('vim-gutentags')
  function! neobundle#hooks.on_source(bundle)
    let g:gutentags_cache_dir = '~/.vim/gutentags'
    let g:gutentags_project_info = get(g:, 'gutentags_project_info', [])
    call add(g:gutentags_project_info, {'type': 'C', 'file': 'configure.ac'})
    call add(g:gutentags_project_info, {'type': 'C', 'file': 'CMakeLists.txt'})
    " Load all tagfiles generated by gutentags
    for tagfile in split(globpath('~/.vim/gutentags', '*'))
      let &tags .= ',' . tagfile
    endfor
  endfunction
  call neobundle#untap()
endif

" }}}

" Manipulation {{{
" ============

NeoBundle 'aklt/vim-simple_comments'
if neobundle#tap('vim-simple_comments')
  function! neobundle#hooks.on_source(bundle)
    let g:simple_comments_Comment = '<c-c>'
    let g:simple_comments_Remove = '<c-x>'
  endfunction
  call neobundle#untap()
endif

NeoBundle 'tpope/vim-repeat'
NeoBundle 'svermeulen/vim-easyclip'
if neobundle#tap('vim-easyclip')
  function! neobundle#hooks.on_source(bundle)
  " Make vim use the system register for copy and paste
  set clipboard=unnamedplus

  let g:EasyClipYankHistorySize = 7
  let g:EasyClipShareYanks = 1
  let g:EasyClipShareYanksDirectory = '$HOME'
  let g:EasyClipShareYanksFile = '.vim/.easyclip'

  let g:EasyClipUseYankDefaults = 1
  let g:EasyClipUseCutDefaults = 0
  let g:EasyClipUsePasteDefaults = 1
  let g:EasyClipEnableBlackHoleRedirect = 0
  let g:EasyClipUsePasteToggleDefaults = 0
  let g:EasyClipUseSubstituteDefaults = 1

  " Disable easyclip pastetoggle override
  let g:EasyClipUseGlobalPasteToggle = 0
  " Paste mode paste in insert mode
  imap <c-v> <plug>EasyClipInsertModePaste
  endfunction
  call neobundle#untap()
endif

NeoBundle 'terryma/vim-multiple-cursors'
if neobundle#tap('vim-multiple-cursors')
  function! neobundle#hooks.on_source(bundle)
    let g:multi_cursor_use_default_mapping=0
    let g:multi_cursor_next_key='<c-d>'
    let g:multi_cursor_prev_key=''
    let g:multi_cursor_skip_key=''
    let g:multi_cursor_quit_key='<Esc>'

    " Called once right before you start selecting multiple cursors
    function! Multiple_cursors_before()
      if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
      endif
    endfunction

    " Called once only when the multiple selection is canceled (default <Esc>)
    function! Multiple_cursors_after()
      if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
      endif
    endfunction
  endfunction
  call neobundle#untap()
endif

" }}}

" Searching {{{
" ============

NeoBundle 'Shougo/unite.vim'
if neobundle#tap('unite.vim')
  function! neobundle#hooks.on_source(bundle)
    " Map space to the prefix for Unite
    nnoremap [unite] <Nop>
    nmap <space> [unite]

    nnoremap [menu] <Nop>
    "nmap <LocalLeader> [menu]
    nmap [unite] [menu]
    nnoremap <silent>[menu]u :Unite -silent -winheight=12 menu<CR>

    " Like ctrlp.vim settings.
    call unite#custom#profile('default', 'context', {
    \   'start_insert': 0,
    \   'direction': 'botright',
    \   'marked-icon': '✓'
    \ })

    let g:unite_prompt = '>>> '
    let g:unite_marked_icon = '✗'

    " Initialize Unite's global list of menus
    if !exists('g:unite_source_menu_menus')
        let g:unite_source_menu_menus = {}
    endif

  function! s:register_quickmenu(name, description, candidate_precursors) " {{{
    " find the length of the longest name
    let max_length = max(map(filter(
          \ deepcopy(a:candidate_precursors),
          \ printf('v:val[0] != "%s"', '-'),
          \), 'len(v:val[0])'))
    " create candidates
    let candidates = []
    for precursor in a:candidate_precursors
      if len(precursor) == 1
        " Separator
        call add(candidates, [
              \ precursor[0],
              \ '',
              \])
      elseif len(precursor) == 2
        " Action (short)
        call add(candidates, [
              \ printf(
              \   printf("▷ %%-%ds", max_length),
              \   precursor[0]
              \ ),
              \ precursor[1],
              \])
      elseif len(precursor) == 3
        " Action
        call add(candidates, [
              \ printf(
              \   printf("▷ %%-%ds    ⚷ %%s", max_length),
              \   precursor[0], precursor[2]
              \ ),
              \ precursor[1],
              \])
      endif
    endfor
    let separator_length = max(map(
          \ deepcopy(candidates),
          \ 'len(v:val[0])',
          \))
    if separator_length % 2 != 0
      let separator_length += 1
    endif
    " register to 'g:unite_source_menu_menus'
    let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})
    let g:unite_source_menu_menus[a:name] = {}
    let g:unite_source_menu_menus[a:name].description = a:description
    let g:unite_source_menu_menus[a:name].candidates = deepcopy(candidates)
    call reverse(g:unite_source_menu_menus[a:name].candidates)
    let g:unite_source_menu_menus[a:name].separator_length = max(map(
          \ deepcopy(candidates),
          \ 'len(v:val[0])',
          \))

    function! g:unite_source_menu_menus[a:name].map(key, value) abort " {{{
      if empty(a:value[1])
        if empty(a:value[0])
          let word = repeat('-', self.separator_length)
        else
          let length = self.separator_length - (len(a:value[0]) + 3)
          let word = printf('- %s %s', a:value[0], repeat('-', length))
        endif
        return {
              \ 'word': word,
              \ 'kind': 'common', 'is_dummy': 1,
              \}
      else
        return {
              \ 'word': a:value[0],
              \ 'kind': 'command',
              \ 'action__command': a:value[1],
              \}
      endif
    endfunction " }}}
  endfunction " }}}

    " Neobundle Menu {{{

    call s:register_quickmenu('NeoBundle', 'Install/Update/Manage plugins            ⚷ [space]n', [
        \['NeoBundle'],
        \['NeoBundle log', 'Unite neobundle/log'],
        \['NeoBundle search', 'Unite neobundle/search'],
        \['NeoBundle update', 'Unite neobundle/update'],
        \['Help'],
        \['NeoBundle docs', 'help NeoBundle'],
    \])

    exe 'nnoremap <silent>[menu]n :Unite -silent -winheight='.(len(g:unite_source_menu_menus.NeoBundle.candidates) + 2).' menu:NeoBundle<CR>'

    " }}}

    " Buffers, tabs and windows operations Menu {{{

    call s:register_quickmenu('Navigation', 'Navigate by buffers, tabs & windows     ⚷ [space]b', [
        \['Buffers', 'Unite buffer'],
        \['Close current window', 'close', '[shift]w'],
        \['Location list', 'Unite location_list'],
        \['New horizontal window', 'split', 'F5'],
        \['New vertical window', 'vsplit', 'F6'],
        \['Tabs', 'Unite tab'],
        \['Toggle quickfix window', 'normal ,ll', ',ll'],
        \['Windows', 'Unite window'],
    \])

    exe 'nnoremap <silent>[menu]b :Unite -silent -winheight='.(len(g:unite_source_menu_menus.Navigation.candidates) + 2).' menu:Navigation<CR>'

    " }}}

    " File's operations {{{

    call s:register_quickmenu('Files', 'Files & dirs                                 ⚷ [space]f', [
        \['Change working directory', 'Unite -default-action=lcd directory'],
        \['Create new file', 'Unite file/new'],
        \['Grep in files', 'normal [unite]/', '[space]/'],
        \['Make new directory', 'Unite directory/new'],
        \['Print current working directory', 'Unite -winheight=3 output:pwd'],
        \['Save as root', 'exe "write !sudo tee % >/dev/null"'],
        \['Search directory recursively', 'Unite -start-insert file_rec/async', '[space][space]'],
        \['Search recently used directories', 'Unite directory_mru'],
        \['Search directory', 'Unite -start-insert directory'],
    \])

    exe 'nnoremap <silent>[menu]f :Unite -silent -winheight='.(len(g:unite_source_menu_menus.Files.candidates) + 2).' menu:Files<CR>'

    " }}}

    " Key Guide {{{

    call s:register_quickmenu('Keyguide', 'Key bindings explained                    ⚷ [space]k', [
        \['Keyguide'],
        \['Leader key mappings', 'normal ,fml', ',fml'],
    \])

    exe 'nnoremap <silent>[menu]k :Unite -silent -winheight='.(len(g:unite_source_menu_menus.Keyguide.candidates) + 2).' menu:Keyguide<CR>'

    " }}}

    " Search for files
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap <silent> [unite]<space> :<C-u>Unite -start-insert file_rec/async:!<CR>

    " Search in files
    let g:unite_source_grep_max_candidates = 200
    nnoremap <silent> [unite]/ :Unite grep:.<cr>
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
    let g:NERDTreeShowBookmarks=1
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

NeoBundle 'tpope/vim-dispatch'

" }}}

" Version Control {{{
" ==============================

" Vim git integration
NeoBundle 'tpope/vim-fugitive'
if neobundle#tap('vim-fugitive')
  function! neobundle#hooks.on_source(bundle)
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

    " Unite menu [[[
    call s:register_quickmenu('Git', 'Admin git repositories                         ⚷ [space]g', [
        \['View'],
        \['git blame       (fugitive)', 'normal ,gb', ',gb'],
        \['git browse      (fugitive)', 'normal ,gw', ',gw'],
        \['git diff        (fugitive)', 'normal ,gd', ',gd'],
        \['git grep        (fugitive)', 'normal ,gg', ',gg'],
        \['git log         (fugitive)', 'normal ,gl', ',gl'],
        \['git status      (fugitive)', 'normal ,gs', ',gs'],
        \['Modify'],
        \['git commit      (fugitive)', 'normal ,gc', ',gc'],
        \['git merge       (fugitive)', 'normal ,gm', ',gm'],
        \['git write       (fugitive)', 'normal ,gr', ',gr'],
        \['Help'],
        \['vim help        (fugitive)', 'help fugitive'],
    \])

    exe 'nnoremap <silent>[menu]g :Unite -silent -winheight='.(len(g:unite_source_menu_menus.Git.candidates) + 3).' menu:Git<CR>'
    " ]]]

  endfunction
  call neobundle#untap()
endif

" Show git diffs in the gutter
NeoBundle 'airblade/vim-gitgutter'
if neobundle#tap('vim-gitgutter')
  function! neobundle#hooks.on_source(bundle)
    " Disabled by default
    let g:gitgutter_enabled = 1
    let g:gitgutter_signs = 1
    let g:gitgutter_highlight_lines = 0
    " Don't show git diff is there are too many changes
    let g:gitgutter_max_signs = 500  " default value
    " Update gitgutter more often
    let g:gitgutter_realtime = 1000
    let g:gitgutter_eager = 1000
  endfunction
  call neobundle#untap()
endif

" A Vim plugin for more pleasant editing on commit messages
NeoBundle 'rhysd/committia.vim'
if neobundle#tap('committia.vim')
  function! neobundle#hooks.on_source(bundle)
    let g:committia_hooks = {}
    function! g:committia_hooks.edit_open(info)
        " Additional settings
        setlocal spell

        " If no commit message, start with insert mode
        if a:info.vcs ==# 'git' && getline(1) ==# ''
            startinsert
        end

        " Scroll the diff window from insert mode
        " Map <C-n> and <C-p>
        imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
        imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)

    endfunction
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

" Look & Feel + nice Buffers {{{
" ==============================

NeoBundle 'vim-ctrlspace/vim-ctrlspace'
if neobundle#tap('vim-ctrlspace')
  function! neobundle#hooks.on_source(bundle)
    let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
    let g:airline_exclude_preview = 1
    let g:CtrlSpaceLoadLastWorkspaceOnStart = 0
    let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
    let g:CtrlSpaceSaveWorkspaceOnExit = 1
  endfunction
  call neobundle#untap()
endif

NeoBundleFetch 'powerline/fonts', { 'build' : 'sh install.sh' }
let font_otf=expand('~/.local/share/fonts/Sauce Code Powerline Medium.otf')
if filereadable(font_otf)
  silent !gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Source Code Pro for Powerline Medium 11"
  let g:airline_powerline_fonts = 1
endif

NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'vim-airline/vim-airline'
if neobundle#tap('vim-airline')
  function! neobundle#hooks.on_source(bundle)
    set laststatus=2
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
    nmap <tab> :CtrlSpaceGoDown<CR>
    " Move to the previous buffer
    nmap <s-tab> :CtrlSpaceGoUp<CR>
    " Close the current buffer and move to the previous one
    nmap <s-w> :bp <BAR> bd #<CR>
  endfunction
  call neobundle#untap()
endif

"NeoBundle 'edkolev/tmuxline.vim'
"if neobundle#tap('tmuxline.vim')
"function! neobundle#hooks.on_source(bundle)
  "let g:tmuxline_preset = {
    "\'a'    : '#S',
    "\'win'  : '#I #W',
    "\'cwin' : '#I #W',
    "\'x'    : ['%a', '%D'],
    "\'y'    : '%R',
    "\'z'    : '#H'}
  "let g:tmuxline_powerline_separators = 1
"endfunction
"call neobundle#untap()
"endif

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

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
  endfunction
  call neobundle#untap()
endif

NeoBundle 'amix/vim-zenroom2'
if neobundle#tap('vim-zenroom2')
  function! neobundle#hooks.on_source(bundle)
  endfunction
  call neobundle#untap()
endif

NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-grammarous'
if neobundle#tap('vim-grammarous')
  function! neobundle#hooks.on_source(bundle)
    let g:grammarous#use_vim_spelllang = 1
    let g:grammarous#default_comments_only_filetypes = {
                \ '*' : 1,
                \ 'help' : 0,
                \ 'markdown' : 0,
                \ 'tex' : 0,
                \ 'text' : 0,
                \ }

    let g:grammarous#hooks = {}
    function! g:grammarous#hooks.on_check(errs)
        nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
        nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
        nmap <buffer><C-f> <Plug>(grammarous-fixit)
        nmap <buffer><C-r> <Plug>(grammarous-remove-error)
        nmap <buffer><C-x> <Plug>(grammarous-reset)
    endfunction

    function! g:grammarous#hooks.on_reset(errs)
        nunmap <buffer><C-n>
        nunmap <buffer><C-p>
        nunmap <buffer><C-f>
        nunmap <buffer><C-r>
        nunmap <buffer><C-x>
    endfunction
  endfunction
  call neobundle#untap()
endif

" }}}

" Optimization {{{
" ==============================

" Disable plugins for LargeFile
NeoBundleLazy 'vim-scripts/LargeFile'
"
" Find and eliminate trailing whitespaces
NeoBundle 'ntpeters/vim-better-whitespace'
if neobundle#tap('vim-better-whitespace')
  function! neobundle#hooks.on_source(bundle)
    autocmd BufWritePre * StripWhitespace
  endfunction
  call neobundle#untap()
endif

" }}}

" Help {{{
" ==============================

NeoBundle 'ktonga/vim-follow-my-lead'
if neobundle#tap('vim-follow-my-lead')
  function! neobundle#hooks.on_source(bundle)
    let g:fml_all_sources = 1
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
autocmd FileType git,gitcommit,gitrebase,markdown,tex,text,tx setlocal formatoptions+=a textwidth=80

autocmd FileType html,xhtml,xml,htmldjango,jinja.html,jinja,eruby,mako setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" go support
" ----------
autocmd BufNewFile,BufRead *.go setlocal ft=go
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Java
" ----
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab formatoptions+=c textwidth=80
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

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

" GSL
" ---
autocmd BufRead,BufNewFile *.gsl set syntax=c

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
  NeoCompleteLock
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set showmode
  set showcmd
  set scrolloff=5
  NeoCompleteUnlock
endfunction

" ==============================================================================
" Keymappings
" ==============================================================================

" Show the Yank Buffer
nnoremap <silent> <leader>2 :Yanks<cr>
" Toggle numbers (relative|absolute)
nnoremap <silent> <leader>6 :call NumberRelativeToggle()<CR>
" Toggle number (on|off)
nnoremap <silent> <leader>7 :call NumberToggle()<CR>
" Toggle spell language (en|de)
nnoremap <silent> <leader>8 :call SpellLangToggle()<CR>
" Toggle spell check (on|off)
nnoremap <silent> <leader>9 :call SpellCheckToggle()<CR>
" Enter writers mode
nnoremap <silent> <leader>0 :Goyo<cr>
" Switch between header and source file
nnoremap <silent> <leader>s :A<cr>


" Use CTRL-S for saving, also in Insert mode
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" Bubble single lines
nmap <a-b> ddkP
nmap <a-f> ddp
" Bubble multiple lines
vmap <a-b> xkP`[V`]
vmap <a-f> xp`[V`]

" F-key Bindings
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :TagbarToggle<CR>
nnoremap <silent> <F4> :VimShellPop<CR>
nmap <F5> :split<CR>
nmap <F6> :vsplit<CR>
nnoremap <F7> :GitGutterLineHighlightsToggle<cr>
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
nmap <a-h> <c-w><c-<>
nmap <a-l> <c-w><c->>
nmap <a-j> <c-w><c-->
nmap <a-k> <c-w><c-+>

" Prepare a substitute command using the current word or the selected text"
nnoremap <leader>r yiw:%s/\<<C-r>"\>/<C-r>"/g<Left><Left><Left>
vnoremap <leader>r y:%s/\<<C-r>"\>/<C-r>"/g<Left><Left><Left>

" Jump to a ctag
nnoremap <leader>k yiw:ta <C-r>"<Left><Left><Left><cr>
vnoremap <leader>k yiw:ta <C-r>"<Left><Left><Left><cr>

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
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$

" ==============================================================================
" Settings and Defaults
" ==============================================================================

set term=screen-256color
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
" Mouse enabled for scrolling, selection, and cursor movement
set mouse=a

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

" ==============================================================================
" Backup, Swap and Undo
" ==============================================================================

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the state of your previous editing session
set viminfo+=n~/.vim/viminfo

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

