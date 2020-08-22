" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"                      .
"      ##############..... ##############
"     _#| |####/  _(_).....(_) |#####| |#   _
"    / _` |/ _ \ |#| | '_ \| | __/ _ \ | | | |
"   | (_| |  __/  _| | | | | | |#  __/ | |_| |
"    \__,_|\___|_|#|_|_| |_|_|\__\___|_|\__, |
"        ##########_...._##| ###..      |___/
"        ######| '_ \./ _ \| __|.....
"      ..######| |#| | (#) | |_.........
"    ....######|_|#|_|\___/#\__|..........
"      ..################JJJ............
"        ################.............
"        ##############.JJJ.JJJJJJJJJJ
"        ############...JJ...JJ..JJ  JJ
"        ##########....JJ...JJ..JJ  JJ
"        ########......JJJ..JJJ JJJ JJJ
"        ######    .........
"                    .....
"                      .
"
" Fully XDG base directory spec complaint ".vimrc" (definitely not vimrc)
" configuration aiming for a small footprint, self-contained, declarative and most
" important CLEAN `$HOME`. "Tidy $HOME, Tidy Mind"
"
" Definitely not Vim is a modern adaptation of [spf13/spf13-vim](https://github.com/spf13/spf13-vim).
" Including XDG base directory, updated [plugins](plugins.vim) sources and the
" best plugin manager out there: [Dein.vim](https://github.com/Shougo/dein.vim)
" }

" Environment {

" XDG base directory specification support {
let g:xdg_configs = {
    \ 'undo': $XDG_DATA_HOME . '/vim/undo',
    \ 'directory': $XDG_DATA_HOME . '/vim/swap',
    \ 'backup': $XDG_DATA_HOME . '/vim/backup',
    \ 'view': $XDG_CACHE_HOME . '/vim/view',
    \ 'info': $XDG_CACHE_HOME . '/vim/info',
    \ 'after': $XDG_CONFIG_HOME . '/vim/after',
    \ }

set viminfo+='1000,n$XDG_CACHE_HOME/vim/info
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

if (has('win32') || has('win64')) " Windows bad
    set runtimepath+=$XDG_CONFIG_HOME/vim/vimfiles,$XDG_CONFIG_HOME/vim/vimfiles/after
else
    set shell=/bin/sh
endif

" Arrow key workaround
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif
" }

" Use before config if available {
if filereadable(expand($XDG_CONFIG_HOME . "/vim/before.vim"))
    source $XDG_CONFIG_HOME/vim/before.vim
endif
" }

" Use plugins config {
if filereadable(expand($XDG_CONFIG_HOME . "/vim/plugins.vim"))
    source $XDG_CONFIG_HOME/vim/plugins.vim
endif
" }

" General {
set background=dark
set nospell

filetype plugin indent on " Automatically detect file types.

syntax on " Syntax highlighting

set term=xterm-256color " works around unknown TERM
set termguicolors
set clipboard=unnamedplus

scriptencoding utf-8
set encoding=utf-8

set mouse=a " Automatically enable mouse usage
set mousehide " Hide the mouse cursor while typing

colorscheme retrowave

" let g:dnotvim_no_autochdir = 1
if !exists('g:dnotvim_no_autochdir')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " Always switch to the current file directory
endif

set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:dnotvim_no_restore_cursor = 1
if !exists('g:dnotvim_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
endif

" Setting up the directories {
set backup                  " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" To disable views add the following to your .vimrc.before.local file:
"   let g:dnotvim_no_views = 1
if !exists('g:dnotvim_no_views')
    " Add exclusions to mkview and loadview
    " eg: *.*, svn-commit.tmp
    let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
endif
" }
" }

" Vim UI {
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode

set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
"highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
endif

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
" To disable the stripping of whitespace, add the following to your
" .vimrc.before.local file:
"   let g:dnotvim_keep_trailing_whitespace = 1

autocmd FileType
 \ c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql
 \ autocmd BufWritePre <buffer> if !exists('g:dnotvim_keep_trailing_whitespace')
   \ call StripTrailingWhitespace()
 \ endif

" following lines would better fit a plugin.
autocmd BufEnter *.html.twig set filetype=html.twig
autocmd BufEnter *.coffee set filetype=coffee syntax=coffee
autocmd BufEnter *.tf,*.tfvars set syntax=terraform
autocmd BufEnter *.kt set syntax=kotlin
autocmd BufEnter *.yaml,*.yml set syntax=yaml

autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType json setlocal conceallevel=2 concealcursor=
autocmd FileType go setlocal ts=4 noexpandtab
autocmd FileType yaml,javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType terraform setlocal commentstring=#%s
autocmd FileType haskell setlocal commentstring=--\ %s
" }

" Key (re)Mappings {
" The default leader is '\', but ',' is prefered, since it's in a standard
" location between keyboard layouts. To overwrite set 'g:dnotvim_leader'.
if !exists('g:dnotvim_leader')
    let mapleader = ','
else
    let mapleader=g:dnotvim_leader
endif

if !exists('g:dnotvim_localleader')
    let maplocalleader = '_'
else
    let maplocalleader=g:dnotvim_localleader
endif

" The default mappings for editing and applying the dnotvim configuration
" are <leader>ev and <leader>sv respectively. Change them in before.vim
"   let g:dnotvim_edit_config_mapping='<leader>ec'
"   let g:dnotvim_apply_config_mapping='<leader>sc'
if !exists('g:dnotvim_edit_config_mapping')
    let s:dnotvim_edit_config_mapping = '<leader>ev'
else
    let s:dnotvim_edit_config_mapping = g:dnotvim_edit_config_mapping
endif
if !exists('g:dnotvim_apply_config_mapping')
    let s:dnotvim_apply_config_mapping = '<leader>sv'
else
    let s:dnotvim_apply_config_mapping = g:dnotvim_apply_config_mapping
endif

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" End/Start of line motion keys act relative to row/wrap width in the
" presence of `:set wrap`, and relative to line for `:set nowrap`.
" Default vim behaviour is to act relative to text line in both cases
"
" If you prefer the default behaviour, put the following in before.vim
" let g:dnotvim_no_wrapRelMotion = 1
if !exists('g:dnotvim_no_wrapRelMotion')
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>

    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>

    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
endif

" The following two lines conflict with moving to top and
" bottom of the screen
" If you prefer that functionality:
"   let g:dnotvim_no_fastTabs = 1
if !exists('g:dnotvim_no_fastTabs')
    map <S-H> gT
    map <S-L> gt
endif

" Stupid shift key fixes
if !exists('g:dnotvim_no_keyfixes')
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif

    cmap Tabe tabe
endif

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Most prefer to toggle search highlighting rather than clear the current
" search results. To clear search highlighting rather than toggle it on
" and off:
"   let g:dnotvim_clear_search_highlight = 1
if exists('g:dnotvim_clear_search_highlight')
    nmap <silent> <leader>/ :nohlsearch<CR>
else
    nmap <silent> <leader>/ :set invhlsearch<CR>
endif

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting does not exit Visual mode
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Easier formatting
nnoremap <silent> <leader>q gwip

" FIXME: Revert this f70be548
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }

" Plugins {

" GoLang {
if count(g:dnotvim_plugin_groups, 'go')
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    au FileType go nmap <Leader>s <Plug>(go-implements)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>e <Plug>(go-rename)
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <leader>co <Plug>(go-coverage)
endif
" }

" TextObj Sentence {
if count(g:dnotvim_plugin_groups, 'writing')
    augroup textobj_sentence
        autocmd!
        autocmd FileType markdown call textobj#sentence#init()
        autocmd FileType textile call textobj#sentence#init()
        autocmd FileType text call textobj#sentence#init()
    augroup END
endif
" }

" TextObj Quote {
if count(g:dnotvim_plugin_groups, 'writing')
    augroup textobj_quote
        autocmd!
        autocmd FileType markdown call textobj#quote#init()
        autocmd FileType textile call textobj#quote#init()
        autocmd FileType text call textobj#quote#init({'educate': 0})
    augroup END
endif
" }

" Misc {
if isdirectory(expand($XDG_CONFIG_HOME. "/vim/plugins/nerdtree"))
    let g:NERDShutUp=1
endif

if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/matchit.zip"))
    let b:match_ignorecase = 1
endif
" }

" OmniComplete {
" To disable omni complete, add the following to your .vimrc.before.local file:
"   let g:dnotvim_no_omni_complete = 1
if !exists('g:dnotvim_no_omni_complete')
    if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
                    \if &omnifunc == "" |
                    \setlocal omnifunc=syntaxcomplete#Complete |
                    \endif
    endif

    hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
    hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
    hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    " Some convenient mappings
    "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
    if exists('g:dnotvim_map_cr_omni_complete')
        inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"
    endif
    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    " Automatically open and close the popup menu / preview window
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    set completeopt=menu,preview,longest
endif
" }

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" NerdTree {
if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/nerdtree"))
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0

    map <C-e> <plug>NERDTreeTabsToggle<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>
endif
" }

" Tabularize {
if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/tabular"))
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    nmap <Leader>a=> :Tabularize /=><CR>
    vmap <Leader>a=> :Tabularize /=><CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
" }

" Session List {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/sessionman.vim/"))
    nmap <leader>sl :SessionList<CR>
    nmap <leader>ss :SessionSave<CR>
    nmap <leader>sc :SessionClose<CR>
endif
" }

" ctrlp {
if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
        " On Windows use "dir" as fallback command.
    elseif executable('rg') " Preferable
        let s:ctrlp_fallback= 'rg %s --color never'
    elseif WINDOWS()
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif
    let g:ctrlp_user_command = {
                \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
                \ }

    if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/ctrlp-funky/"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']

        "funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
    endif
endif
"}

" Rainbow demiliters {
if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/rainbow/"))
    let g:rainbow_active = 1
endif
"}

" Fugitive (Git) {
if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/vim-fugitive/"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
endif
"}

" YouCompleteMe {
if count(g:dnotvim_plugin_groups, 'youcompleteme')
    let g:acp_enableAtStartup = 0

    " enable completion from tags
    let g:ycm_collect_identifiers_from_tags_files = 1

    " remap Ultisnips for compatibility for YCM
    let g:UltiSnipsExpandTrigger = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

    set completeopt-=preview
endif
" }

if isdirectory(expand($XDG_CONFIG_HOME . "/vim/plugins/vim-airline-themes/"))
    if !exists('g:airline_theme')
        let g:airline_theme = 'monochrome'
    endif

    if !exists('g:airline_powerline_fonts')
        let g:airline_left_sep='>'
        let g:airline_right_sep='<'
    endif
endif
" }

" Functions {

" Initialize directories {
function! InitializeXDGDirectories()
    let directories = [
        \ g:xdg_configs.directory,
        \ g:xdg_configs.backup,
        \ g:xdg_configs.view,
        \ g:xdg_configs.after,
        \ ]

    if has('persistent_undo')
        call add(directories, g:xdg_configs.undo)
    endif

    for dirname in directories
        if exists("*mkdir")
            if !isdirectory(dirname)
                call mkdir(dirname, 'p')
            endif
        endif

        if !isdirectory(dirname)
            echo "Warning: Unable to create directory: " . dirname
        endif

    exec "set undodir =" . g:xdg_configs.undo
    exec "set directory =" . g:xdg_configs.directory
    exec "set backupdir =" . g:xdg_configs.backup
    exec "set viewdir =" . g:xdg_configs.view
    exec "set viminfo+='1000,n" . g:xdg_configs.info
    exec "set runtimepath+=" . $XDG_CONFIG_HOME . "/vim," . $VIMRUNTIME . "," . g:xdg_configs.after
    endfor
endfunction
call InitializeXDGDirectories()
" }

" Initialize NERDTree as needed {
function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction
" }

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }
" }
