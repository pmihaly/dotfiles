let mapleader =" "


if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'

Plug 'dylanaraps/wal.vim'

Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm'
Plug 'axvr/org.vim'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
call plug#end()

" Super basic settings
    set title
    set bg=light
    set go=a
    set mouse=a
    set nohlsearch
    set ignorecase
    set clipboard+=unnamedplus
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    set autochdir

    colorscheme wal

    set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
    set t_8b=^[[48;2;%lu;%lu;%lum        " set background color
    set t_Co=256                         " Enable 256 colors

" when using vim as diff
if &diff
    " use zR to open all folds
    set cursorline
    noremap n ]c
    noremap N [c
    noremap l dp<CR>
    noremap h do<CR>
endif

" compliation
    map <leader>cm :!markmap "%"<CR>
    map <leader>cp :!pandoc -t ms "%" -o "%.pdf"<CR>
    map <leader>cc :w \| !gcc -lm "%" && ./a.out<CR>
    map <leader>csh :!clear && shellcheck -x %<CR>
    map <leader>csl :terminal sudo make install<CR>

" insertion
    map <leader>ic :-1r!curl -s http://whatthecommit.com/index.txt<CR>

    map <leader>pi :PlugInstall<CR>
    map <leader>pc :PlugClean<CR>
    map <leader>pud :PlugUpdate<CR>
    map <leader>pug :PlugUpgrade<CR>

" Indenting
    vmap <silent> <A-h> <gv
    vmap <silent> <A-l> >gv

    nmap <silent> <A-h> a<C-d><Esc>
    nmap <silent> <A-l> a<C-t><Esc>

    imap <silent> <A-h> <C-d>
    imap <silent> <A-l> <C-t>

" Moving lines
    vmap <silent> <A-j> :move +1<CR>
    vmap <silent> <A-k> :move -2<CR>

    nmap <silent> <A-j> :move +1<CR>
    nmap <silent> <A-k> :move -2<CR>

    imap <silent> <A-j> <Esc>:move +1<CR>
    imap <silent> <A-k> <Esc>:move -2<CR>

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Goyo plugin makes text more readable when writing prose:
	map <silent> <leader>f :Goyo \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_gb,hu,de_de<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright
" Managing tabs
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set expandtab
	set autoindent
	set fileformat=unix


"""" CUSTOM SETTINGS

" sneak
    let g:sneak#s_next = 1
    let g:sneak#use_ic_scs = 1
    let g:sneak#label = 1
    let g:sneak#label_esc = "\<Space>"
    let g:sneak#target_labels = "fjdkslaéá"
    highlight Sneak ctermfg=black ctermbg=red

    map á <Plug>Sneak_;
    map é <Plug>Sneak_,

" floaterm
    map <leader>t :FloatermToggle<CR>
    map <leader>g :FloatermNew --disposable lazygit<CR>
    let g:floaterm_autoclose = 1

" org.vim
    syntax enable
    filetype plugin indent on

" fzf

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

	map <leader><space> :Files<CR>
	" map <leader>r :Rg<CR>
	map <leader>r :RG<CR>

" vimwiki
	let g:vimwiki_global_ext = 0
	let g:vimwiki_list = [{'path': '~/sync/vimwiki/', 'auto_diary_index': 1, 'syntax': 'markdown', 'ext': '.md'}]

" emmet
    let g:user_emmet_mode='n'
    let g:user_emmet_leader_key=','

" Window navigation
	noremap <leader>q :q!<CR>
	noremap <leader>ww :w<CR>
	noremap <leader>we :wq<CR>
    " Pressing W by accident -> save file
    cnoreabbrev W w
	map <leader>wv :vs<CR>

" Tab navigation
	map <leader>wn :tabnew<CR>
	noremap <M-1> 1gt<CR>
	noremap <M-2> 2gt<CR>
	noremap <M-3> 3gt<CR>
	noremap <M-4> 4gt<CR>
	noremap <M-5> 5gt<CR>
	noremap <M-6> 6gt<CR>
	noremap <M-7> 7gt<CR>
	noremap <M-8> 8gt<CR>
	noremap <M-9> 9gt<CR>

	inoremap <M-1> <esc>1gt<CR>
	inoremap <M-2> <esc>2gt<CR>
	inoremap <M-3> <esc>3gt<CR>
	inoremap <M-4> <esc>4gt<CR>
	inoremap <M-5> <esc>5gt<CR>
	inoremap <M-6> <esc>6gt<CR>
	inoremap <M-7> <esc>7gt<CR>
	inoremap <M-8> <esc>8gt<CR>
	inoremap <M-9> <esc>9gt<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

	map <leader>wh <C-w>h
	map <leader>wj <C-w>j
	map <leader>wk <C-w>k
	map <leader>wl <C-w>l


" Replace ex mode with gq
	map Q gq

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
" 	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
" 	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
" 	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
" 	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

" sxhkd
    autocmd BufWritePost sxhkdrc !killall -q sxhkd;setsid -f sxhkd

" sorting
	autocmd BufWritePre ~/.config/pkgs,~/.config/bookmark-configs,~/.config/bookmark-dirs,~/sync/streams :sort

" newsboat urls sorting
    autocmd BufWritePre ~/.config/newsboat/urls :sort /.*youtube.com.* # /

" slstatus rerun
    autocmd BufWritePost ~/.config/slstatus/config.h :terminal cd ~/.config/slstatus/ && sudo make install && { killall -q slstatus;setsid -f slstatus }


" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

"""""""""""""""""""""""
" COC
"""""""""""""""""""""""



" Custom
map <A-a> :CocAction<CR>
map <A-c> :CocCommand<CR>
map <silent> <A-f> :CocCommand explorer<CR>
map <A-p> :w \| CocCommand python.execInTerminal<CR>
" map <A-l> :CocList<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_global_extensions = [
	\ 'coc-snippets',
	\ 'coc-pairs',
	\ 'coc-prettier',
	\ 'coc-tsserver',
	\ 'coc-html',
	\ 'coc-css',
	\ 'coc-json',
	\ 'coc-explorer',
	\ 'coc-vimtex',
  \ 'coc-pyright',
  \ 'coc-marketplace'
	\ ]


" From Coc Readme
set updatetime=300

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <C-j>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Remap for rename current word
nmap <rn> <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" SHOULD BE LAST
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar
