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

" Definitely not Vim is a modern adaptation of [spf13/spf13-vim](https://github.com/spf13/spf13-vim).
" Including XDG base directory, updated [plugins](plugins.vim) sources and the
" best plugin manager out there: [Dein.vim](https://github.com/Shougo/dein.vim)
" }

" Bundles {
set runtimepath+=$XDG_CONFIG_HOME/vim/plugins/dein.vim " a.k.a. rtp

" Deps {

call dein#begin('$XDG_CONFIG_HOME/vim/plugins')
call dein#add('$XDG_CONFIG_HOME/vim/plugins/dein.vim')

if executable('rg') " Recommended
    call dein#add('jremmen/vim-ripgrep')
elseif executable('ag') || executable('ack')
    call dein#add('mileszs/ack.vim')
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
elseif executable('ack-grep')
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    call dein#add('mileszs/ack.vim')
endif
" }

" In your .vimrc.before.local file
" list only the plugin groups you will use
if !exists('g:dnotvim_plugin_groups')
    let g:dnotvim_plugin_groups=['general', \
    'writing', \
    'neocomplete', \
    'programming', \
    'python', \
    'javascript', \
    'html', \
    'misc',]
endif

" General {
if count(g:dnotvim_plugin_groups, 'general')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('junegunn/goyo.vim')

    call dein#add('scrooloose/nerdtree')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('rhysd/conflict-marker.vim')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('tacahiroy/ctrlp-funky')
    call dein#add('vim-scripts/sessionman.vim')
    call dein#add('vim-scripts/matchit.zip')

    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('powerline/fonts')
    call dein#add('bling/vim-bufferline')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('jistr/vim-nerdtree-tabs')
    call dein#add('mbbill/undotree')
    call dein#add('nathanaelkane/vim-indent-guides')

    if !exists('g:dnotvim_no_views')
        call dein#add('vim-scripts/restore_view.vim')
    endif

    call dein#add('mhinz/vim-signify')
    call dein#add('tpope/vim-abolish.git')
    call dein#add('osyo-manga/vim-over')
    call dein#add('kana/vim-textobj-user')
    call dein#add('kana/vim-textobj-indent')
    call dein#add('gcmt/wildfire.vim')
endif
" }

" Writing {
if count(g:dnotvim_plugin_groups, 'writing')
    call dein#add('reedes/vim-litecorrect')
    call dein#add('reedes/vim-textobj-sentence')
    call dein#add('reedes/vim-textobj-quote')
    call dein#add('reedes/vim-wordy')
endif
" }

" General Programming {
if count(g:dnotvim_plugin_groups, 'programming')
    " Pick one of the checksyntax, jslint, or syntastic
    call dein#add('scrooloose/syntastic')
    call dein#add('tpope/vim-fugitive')
    call dein#add('mattn/webapi-vim')
    call dein#add('vim-scripts/dbext.vim')

    call dein#add('mattn/gist-vim')
    call dein#add('tpope/vim-commentary')
    call dein#add('godlygeek/tabular')
    call dein#add('luochen1990/rainbow')

    if executable('ctags')
        call dein#add('majutsushi/tagbar')
    endif
endif
" }

" Infra {
if count(g:dnotvim_plugin_groups, 'infra')
    call dein#add('LnL7/vim-nix')

    call dein#add('bracki/vim-prometheus')
    call dein#add('hashivim/vim-terraform')
endif
" }

" Snippets & AutoComplete {
if count(g:dnotvim_plugin_groups, 'snippets')
    call dein#add('garbas/vim-snipmate')
    call dein#add('honza/vim-snippets')
    " Source support_function.vim to support vim-snippets.
    if filereadable(expand($XDG_CONFIG_HOME . '/vim/bundle/vim-snippets/snippets/support_functions.vim'))
        source $XDG_CONFIG_HOME/vim/bundle/vim-snippets/snippets/support_functions.vim
    endif
elseif count(g:dnotvim_plugin_groups, 'youcompleteme')
    call dein#add('Valloric/YouCompleteMe')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')
elseif count(g:dnotvim_plugin_groups, 'neocomplete')
    call dein#add('Shougo/neocomplete.vim.git')
    call dein#add('Shougo/neocomplcache')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('honza/vim-snippets')
endif
" }

" Python {
if count(g:dnotvim_plugin_groups, 'python')
    call dein#add('nvie/vim-flake8')
    call dein#add('davidhalter/jedi-vim')
endif
" }

" Javascript {
if count(g:dnotvim_plugin_groups, 'javascript')
    call dein#add('elzr/vim-json')
    call dein#add('pangloss/vim-javascript')
    call dein#add('kchmck/vim-coffee-script')
endif
" }

" Scala {
if count(g:dnotvim_plugin_groups, 'scala')
    call dein#add('derekwyatt/vim-scala')
    call dein#add('derekwyatt/vim-sbt')
endif
" }

" Haskell {
if count(g:dnotvim_plugin_groups, 'haskell')
    call dein#add('travitch/hasksyn')
    call dein#add('dag/vim2hs')
    call dein#add('Twinside/vim-haskellConceal')
    call dein#add('Twinside/vim-haskellFold')
    call dein#add('lukerandall/haskellmode-vim')
    call dein#add('eagletmt/neco-ghc')
    call dein#add('eagletmt/ghcmod-vim')
    call dein#add('Shougo/vimproc.vim')
    call dein#add('adinapoli/cumino')
    call dein#add('bitc/vim-hdevtools')
endif
" }

" HTML {
if count(g:dnotvim_plugin_groups, 'html')
    call dein#add('hail2u/vim-css3-syntax')
    call dein#add('gorodinskiy/vim-coloresque')
    call dein#add('tpope/vim-haml')
    call dein#add('mattn/emmet-vim')
endif
" }

" Ruby {
if count(g:dnotvim_plugin_groups, 'ruby')
    call dein#add('tpope/vim-rails')

    let g:rubycomplete_buffer_loading = 1
endif
" }

" Go Lang {
if count(g:dnotvim_plugin_groups, 'go')
    call dein#add('fatih/vim-go')
endif
" }

" Rust {
if count(g:dnotvim_plugin_groups, 'go')
    call dein#add('rust-lang/rust.vim')
endif
" }

" Elixir {
if count(g:dnotvim_plugin_groups, 'elixir')
    call dein#add('elixir-lang/vim-elixir')
    call dein#add('carlosgaldino/elixir-snippets')
    call dein#add('mattreduce/vim-mix')
endif
" }

" Misc {
if count(g:dnotvim_plugin_groups, 'misc')
    call dein#add('sbdchd/neoformat')
    call dein#add('tpope/vim-markdown')
    call dein#add('cespare/vim-toml')
    call dein#add('greyblake/vim-preview')
    call dein#add('Glench/Vim-Jinja2-Syntax')
endif
" }
" }

call dein#end()
call dein#save_state()

" Check for uninstalled plugins on start
if dein#check_install()
    call dein#install()
endif
