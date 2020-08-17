" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"
"    ##############..... ##############
"    ##############......##############
"     ###########._ ......_###########
"   __| |####/  _(_).....(_) |#####| |_   _
"  / _` |/ _ \ |#| | '_ \| | __/ _ \ | | | |
" | (_| |  __/  _| | | | | | |#  __/ | |_| |
"  \__,_|\___|_|#|_|_| |_|_|\__\___|_|\__, |
"      ##########.......########      |___/
"      ##########_...._##| |###..
"      ######| '_ \./ _ \| __|.....
"    ..######| |#| | (#) | |_.........
"  ....######|_|#|_|\___/ \__|..........
"    ..################JJJ............
"      ################.............
"      ##############.JJJ.JJJJJJJJJJ
"      ############...JJ...JJ..JJ  JJ
"      ##########....JJ...JJ..JJ  JJ
"      ########......JJJ..JJJ JJJ JJJ
"      ######    .........
"                  .....
"                    .
"
"   This is definitely not the Vim configuration you're looking for.
"
"   Fully XDG base directory spec complaint ".vimrc" (definitely not)
"   configuration aiming for a small footprint.
"
"   Most of this file came from github.com/spf13/spf13-vim.
"   However, it's worth mentioning that spf13-vim itself is abandoned,
"   as well as the Vundle (plugin manager) used in the setup.
"
"   For a modern setup I suggest replacing Vundle with Neobundle, plus
"   a refactor in the bundles.vim. Ref: github.com/Shougo/neobundle.vim
" }

" Environment {
set rtp+=$XDG_CONFIG_HOME/vim/bundle/vundle
call vundle#rc('bundle')
" }

" Bundles {

" Deps {
Bundle 'VundleVim/Vundle.vim'

if executable('ag') || executable('ack')
    Bundle 'mileszs/ack.vim'
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
elseif executable('ack-grep')
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    Bundle 'mileszs/ack.vim'
elseif executable('rg')
    Bundle 'jremmen/vim-ripgrep'
endif
" }

" In your .vimrc.before.local file
" list only the plugin groups you will use
if !exists('g:dnotvim_bundle_groups')
    let g:dnotvim_bundle_groups=['general', \
    'writing', \
    'neocomplete', \
    'programming', \
    'python', \
    'javascript', \
    'html', \
    'misc',]
endif

" General {
if count(g:dnotvim_bundle_groups, 'general')
    Bundle 'christoomey/vim-tmux-navigator'
    Bundle 'editorconfig/editorconfig-vim'
    Bundle 'junegunn/goyo.vim'

    Bundle 'scrooloose/nerdtree'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-repeat'
    Bundle 'rhysd/conflict-marker.vim'
    Bundle 'jiangmiao/auto-pairs'
    Bundle 'ctrlpvim/ctrlp.vim'
    Bundle 'tacahiroy/ctrlp-funky'
    Bundle 'vim-scripts/sessionman.vim'
    Bundle 'matchit.zip'

    Bundle 'vim-airline/vim-airline'
    Bundle 'vim-airline/vim-airline-themes'

    Bundle 'powerline/fonts'
    Bundle 'bling/vim-bufferline'
    Bundle 'easymotion/vim-easymotion'
    Bundle 'jistr/vim-nerdtree-tabs'
    Bundle 'mbbill/undotree'
    Bundle 'nathanaelkane/vim-indent-guides'

    if !exists('g:dnotvim_no_views')
        Bundle 'vim-scripts/restore_view.vim'
    endif

    Bundle 'mhinz/vim-signify'
    Bundle 'tpope/vim-abolish.git'
    Bundle 'osyo-manga/vim-over'
    Bundle 'kana/vim-textobj-user'
    Bundle 'kana/vim-textobj-indent'
    Bundle 'gcmt/wildfire.vim'
endif
" }

" Writing {
if count(g:dnotvim_bundle_groups, 'writing')
    Bundle 'reedes/vim-litecorrect'
    Bundle 'reedes/vim-textobj-sentence'
    Bundle 'reedes/vim-textobj-quote'
    Bundle 'reedes/vim-wordy'
endif
" }

" General Programming {
if count(g:dnotvim_bundle_groups, 'programming')
    " Pick one of the checksyntax, jslint, or syntastic
    Bundle 'scrooloose/syntastic'
    Bundle 'tpope/vim-fugitive'
    Bundle 'mattn/webapi-vim'
    Bundle 'vim-scripts/dbext.vim'

    Bundle 'rust-lang/rust.vim'
    Bundle 'mattn/gist-vim'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'tpope/vim-commentary'
    Bundle 'godlygeek/tabular'
    Bundle 'luochen1990/rainbow'
    if executable('ctags')
        Bundle 'majutsushi/tagbar'
    endif
endif
" }

" Infra {
if count(g:dnotvim_bundle_groups, 'infra')
    Bundle 'LnL7/vim-nix'

    Bundle 'bracki/vim-prometheus'
    Bundle 'hashivim/vim-terraform'
endif
" }
" Snippets & AutoComplete {
if count(g:dnotvim_bundle_groups, 'snippets')
    Bundle 'garbas/vim-snipmate'
    Bundle 'honza/vim-snippets'
    " Source support_function.vim to support vim-snippets.
    if filereadable(expand($XDG_CONFIG_HOME . '/vim/bundle/vim-snippets/snippets/support_functions.vim'))
        source $XDG_CONFIG_HOME/vim/bundle/vim-snippets/snippets/support_functions.vim
    endif
elseif count(g:dnotvim_bundle_groups, 'youcompleteme')
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'SirVer/ultisnips'
    Bundle 'honza/vim-snippets'
elseif count(g:dnotvim_bundle_groups, 'neocomplete')
    Bundle 'Shougo/neocomplete.vim.git'
    Bundle 'Shougo/neocomplcache'
    Bundle 'Shougo/neosnippet'
    Bundle 'Shougo/neosnippet-snippets'
    Bundle 'honza/vim-snippets'
endif
" }

" Python {
if count(g:dnotvim_bundle_groups, 'python')
    " Pick either python-mode or pyflakes & pydoc
    Bundle 'klen/python-mode'
    Bundle 'yssource/python.vim'
    Bundle 'python_match.vim'
    Bundle 'pythoncomplete'
endif
" }

" Javascript {
if count(g:dnotvim_bundle_groups, 'javascript')
    Bundle 'elzr/vim-json'
    Bundle 'groenewege/vim-less'
    Bundle 'pangloss/vim-javascript'
    Bundle 'briancollins/vim-jst'
    Bundle 'kchmck/vim-coffee-script'
endif
" }

" Scala {
if count(g:dnotvim_bundle_groups, 'scala')
    Bundle 'derekwyatt/vim-scala'
    Bundle 'derekwyatt/vim-sbt'
    Bundle 'xptemplate'
endif
" }

" Haskell {
if count(g:dnotvim_bundle_groups, 'haskell')
    Bundle 'travitch/hasksyn'
    Bundle 'dag/vim2hs'
    Bundle 'Twinside/vim-haskellConceal'
    Bundle 'Twinside/vim-haskellFold'
    Bundle 'lukerandall/haskellmode-vim'
    Bundle 'eagletmt/neco-ghc'
    Bundle 'eagletmt/ghcmod-vim'
    Bundle 'Shougo/vimproc.vim'
    Bundle 'adinapoli/cumino'
    Bundle 'bitc/vim-hdevtools'
endif
" }

" HTML {
if count(g:dnotvim_bundle_groups, 'html')
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'gorodinskiy/vim-coloresque'
    Bundle 'tpope/vim-haml'
    Bundle 'mattn/emmet-vim'
endif
" }

" Ruby {
if count(g:dnotvim_bundle_groups, 'ruby')
    Bundle 'tpope/vim-rails'
    let g:rubycomplete_buffer_loading = 1
    "let g:rubycomplete_classes_in_global = 1
    "let g:rubycomplete_rails = 1
endif
" }

" Go Lang {
if count(g:dnotvim_bundle_groups, 'go')
    "Bundle 'Blackrush/vim-gocode'
    Bundle 'fatih/vim-go'
endif
" }

" Elixir {
if count(g:dnotvim_bundle_groups, 'elixir')
    Bundle 'elixir-lang/vim-elixir'
    Bundle 'carlosgaldino/elixir-snippets'
    Bundle 'mattreduce/vim-mix'
endif
" }

" Misc {
if count(g:dnotvim_bundle_groups, 'misc')
    Bundle 'sbdchd/neoformat'
    Bundle 'tpope/vim-markdown'
    Bundle 'dnotvim/vim-preview'
    Bundle 'cespare/vim-toml'
    Bundle 'Glench/Vim-Jinja2-Syntax'
endif
" }
" }
