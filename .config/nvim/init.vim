let mapleader =" "


if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'ap/vim-css-color'

Plug 'dylanaraps/wal.vim'

Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'voldikss/vim-floaterm'
Plug 'axvr/org.vim'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
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

" compliation/formatting
    map <leader>cm :!markmap "%"<CR>
    " convert through latex asynchronously if possible
    map <leader>cp :w \| Spawn! [ -e "%.pdf" ] && (pandoc --pdf-engine=xelatex "%" -o "%.pdf" & pidof zathura \|\| zathura "%.pdf") \|\| (pandoc --pdf-engine=xelatex "%" -o "%.pdf" && pidof zathura \|\| zathura "%.pdf") <CR>
    " conver with debugging
    map <leader>cpd :w \| Spawn [ -e "%.pdf" ] && (pandoc --pdf-engine=xelatex "%" -o "%.pdf" & pidof zathura \|\| zathura "%.pdf") \|\| (pandoc --pdf-engine=xelatex "%" -o "%.pdf" && pidof zathura \|\| zathura "%.pdf") <CR>
    " convert through groff
    map <leader>cgp :!pandoc -t ms "%" -o "%.pdf"<CR>
    map <leader>cc :w \| !gcc -lm "%" && ./a.out<CR>
    map <leader>cpp :w \| !fpc -o"%.out" "%" && ./%.out<CR>
    map <leader>csh :!clear && shellcheck -x %<CR>
    map <leader>csl :Spawn sudo make install<CR>
    map <leader>cst :!devour sent "%"<CR>
    map <leader>cf :!prettier -w "%"<CR>

" Pascal notetaking snippets
    inoremap <c-i>pc <CR>```pascal<CR><CR>```<ESC>ki
    inoremap <c-i>bt ``<ESC>i

" Latex math snippets
    inoremap <c-i>su \sum_{i=0}^{}<ESC>i
    inoremap <c-i>fr \frac{}{}<ESC>ba
    inoremap <c-i>fo \forall  : <ESC>bhi
    inoremap <c-i>mul \cdot
    inoremap <c-i>... \dots

    inoremap <c-i>ge \geq
    inoremap <c-i>le \leq

    inoremap <c-i>ra \rightarrow
    inoremap <c-i>la \leftarrow

    inoremap <c-i>ho ^{}<ESC>i
    inoremap <c-i>un _{}<ESC>i

    inoremap <c-i>bb \mathbb{}<ESC>i
    inoremap <c-i>bbn \mathbb{N}
    inoremap <c-i>in \in
    inoremap <c-i>inn  \in \mathbb{N}

    inoremap <c-i>ma $$<ESC>i
    inoremap <c-i>mu <CR>(@) $$$$<ESC>hi
    inoremap <c-i>mua <CR>(@) $$\begin{aligned}  \end{aligned}$$<ESC>Bhi


" insertion from shell
    map <leader>ic :-1r!curl -s http://whatthecommit.com/index.txt<CR>
    map <leader>iq :-1r!pandoc https://dailystoic.pappmihaly.com --to gfm -o /dev/stdout<CR>

" Opening links with ~/.local/bin/linkhandler script
    map <leader><CR> :execute 'silent! !linkhandler "<cfile>" &> /dev/null &' <bar> redraw! <CR>

" plug commands
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

" Open path in new split
    map gf :vertical wincmd f<CR>

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
    autocmd BufWritePost sxhkdrc !killall -q sxhkd; sxhkd &

" wal templates
    autocmd BufWritePost *wal/templates/* !wal -c;wal -R;wal -R

" sorting
	autocmd BufWritePre ~/.config/pkgs,~/.config/bookmark-configs,~/.config/bookmark-dirs,~/sync/streams :sort i

" newsboat urls sorting
    autocmd BufWritePre ~/.config/newsboat/urls :sort i /.*youtube.com.* # /

" slstatus rerun
    autocmd BufWritePost ~/.config/slstatus/config.h :terminal cd ~/.config/slstatus/ && sudo make install && { killall -q slstatus;setsid -f slstatus }


" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" SHOULD BE LAST
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar
