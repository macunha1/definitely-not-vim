" Commands to execute before the Plugins are loaded
" Customizations are (usually) better suited here.

let g:dnotvim_bundle_groups = ['general', 'programming', 'infra', 'misc']

let g:vim_json_syntax_concealcursor = ''
let g:vim_json_syntax_conceal = 0

let g:neoformat_enabled_python = ['autopep8', 'yapf']
let g:neoformat_enabled_ruby = ['rubocop']

let g:terraform_align = 0
let g:terraform_fmt_on_save = 1

" Theme and visual configurations {
"" Airline unicode symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = 'monochrome'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

let g:Powerline_symbols = 'fancy'

let g:rainbow_active = 1
let g:retrowave_default_termcolors = 1
let g:retrowave_rainbow_colors = 1
" }
