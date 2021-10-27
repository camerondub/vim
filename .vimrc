" VIM "
autocmd!
execute pathogen#infect()
syntax on
filetype plugin indent on

" general bindings
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <C-B> ,
inoremap <Nul> <C-X><C-O>
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>
let mapleader=","
let maplocalleader="\<Space>"
nnoremap <leader>td :Ack! TODO .<CR>
nnoremap <leader>cd     :tcd<space>
nnoremap <leader>cn 	:call NextSummary()<CR>
nnoremap <leader>cp 	:call PrevSummary()<CR>
nnoremap <leader>cc 	:call CurrentSummary()<CR>
nnoremap <leader>cq	:call CloseSummary()<CR>
nnoremap <leader>co	:call OpenQuickfix('')<CR>
nnoremap <leader>ct	:checktime<CR>
nnoremap <leader>cg	:set nornu<CR>:set signcolumn=no<CR>
nnoremap <leader>cr	:set rnu<CR>:set signcolumn=yes<CR>
nnoremap <leader>pq	:pc<CR>
nnoremap <leader>pt	:ptag <C-R><C-W><CR>
nnoremap <leader>pg     :setlocal paste<CR>
nnoremap <leader>pr     :setlocal nopaste<CR>
nnoremap <leader>ln 	:lne<CR>
nnoremap <leader>lp 	:lp<CR>
nnoremap <leader>ll 	:ll<CR>
nnoremap <leader>lq	:lcl<CR>
nnoremap <leader>lo	:call OpenLocation()<CR>
nnoremap <leader>f	:call setloclist(0, [])<CR>:LAck!<space>
nnoremap <leader>rr :redr!<CR>
nnoremap <leader>ro :view<CR>
nnoremap <leader>rw :edit<CR>
nnoremap <leader>hm 	:Make!<space>
nnoremap <leader>hi 	:Make! install -j4 BUILD=debug<CR>
nnoremap <leader>mm 	:Make<space>
nnoremap <leader>mi 	:Make install -j4 BUILD=debug<CR>
nnoremap <leader>do     :call OpenQuickfix('dispatch')<CR>
nnoremap <leader>dl     :call OpenQuickfix('dispatch')<CR><C-w>l:q<CR>
nnoremap <leader>dh     :call OpenQuickfix('dispatch')<CR><C-w>h:q<CR>
nnoremap <leader>;	:noh<CR>
nnoremap <leader>hh	:set hls!<CR>
nnoremap <leader>jf     :execute '%!python3 -m json.tool'<CR>:set ft=json<CR>:w<CR>
nnoremap gw :w<CR>


" note bindings
function! SwitchToNote(name)
    if bufname(a:name) == ""
        split
        if a:name ==# 'unsorted.md'
            lcd ~/org
        endif
        execute "edit " . a:name
    else
        set switchbuf=useopen
        execute "sbuf " . a:name
        if a:name ==# 'unsorted.md'
            lcd ~/org
        endif
        set switchbuf=
    endif
endfunction
nnoremap <leader>en :call SwitchToNote('.note.md')<CR>
nnoremap <leader>ee :call SwitchToNote('.env')<CR>

" formatting bindings
nmap \w	:setlocal wrap!<CR>:setlocal wrap?<CR>
nmap \p	:setlocal paste!<CR>:setlocal paste?<CR>
nmap \w :RMVWS<CR>:noh<CR>
nmap \t :setlocal sw=4 sts=4 et<CR>
nmap \T :setlocal sw=8 sts=0 et<CR>
nmap \y :wincmd o<CR>:set nornu<CR>:set scl=no<CR>
nmap \n :set rnu<CR>:set scl=yes<CR>

" window layout
nnoremap <leader>1	<C-w>1w
nnoremap <leader>2	<C-w>2w
nnoremap <leader>3	<C-w>3w
nnoremap <leader>4	<C-w>4w
nnoremap <leader>5	<C-w>5w
nnoremap <leader>6	<C-w>6w
nnoremap <leader>7	<C-w>7w
nnoremap <leader>8	<C-w>8w
nnoremap <leader>9	<C-w>9w


" sessions and layout
function! Resize(width, height) abort
    exe 'vert resize ' . a:width
    exe 'resize ' . a:height
endfunction

nnoremap <leader>l1	<C-w>o:TagbarToggle<CR>:NERDTreeToggle<CR><C-w>h
nnoremap <leader>l2	<C-w>o<C-w>v<C-w>h:e .note.md<CR><C-w>l
nnoremap <leader>lf	<C-w>o<C-w>s<C-w>k:TagbarToggle<CR>:NERDTreeToggle
    \<CR><C-w>h:e .note.md<CR><C-w>j
nnoremap <leader>l4	<C-w>o<C-w>s<C-w>v<C-w>k<C-w>v<C-w>h:e .note.md<CR><C-w>j

" wincmds
nnoremap gq <C-w>q
nnoremap <leader>w	<nop>
nnoremap <leader>wo	<C-w>o
nnoremap <leader>wI     :resize +10<CR>
nnoremap <leader>wi     :resize +1<CR>
nnoremap <leader>wD     :resize -10<CR>
nnoremap <leader>wd     :resize -1<CR>
nnoremap <leader>wh     <C-w>h
nnoremap <leader>wj     <C-w>j
nnoremap <leader>wk     <C-w>k
nnoremap <leader>wl     <C-w>l
nnoremap <leader>wv     <C-w>v
nnoremap <leader>ws     <C-w>s
nnoremap <leader>wb	<C-w>b
nnoremap <leader>wt	<C-w>t
nnoremap <leader>wc     :cope<CR>
nnoremap <leader>wr	<C-w>r
nnoremap <leader>we	<C-w>=
nnoremap <leader>wp	<C-w>p
nnoremap <leader>wx	<C-w>x

" summary windows
function! OpenQuickfix(type) abort
  8split
  if a:type ==# 'dispatch'
      Copen
  else
      copen
  endif
  let bufn = bufnr('%')
  let winn = winnr()
  wincmd p
  execute 'b'.bufn
  execute winn.'close'
  if len(getqflist()) == 0
      cclose
  else
      wincmd k
  endif
endfunction

function! OpenLocation() abort
    lopen
    if len(getloclist(0)) == 0
        lclose
    else
        wincmd p
    endif
endfunction

function! NextSummary() abort
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        silent! lnext
    else
        silent! cnext
    endif
endfunction

function! PrevSummary() abort
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        silent! lpre
    else
        silent! cpre
    endif
endfunction

function! CurrentSummary() abort
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        silent! ll
    else
        silent! cc
    endif
endfunction

function! CloseSummary() abort
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        silent! lcl
    else
        silent! ccl
    endif
endfunction

" man runtime
runtime! ftplugin/man.vim

" macros
command! FLIPSCORE %s/\v\W+\zs_(\a+)/\1_/g
command! RMVWS %s/\s\+$//e
command! CDF cd %:p:h
command! LCDF lcd %:p:h
command! GA Git add .

" autocmds
autocmd FileType *      setlocal formatoptions=tcqln nocindent
autocmd FileType *      setlocal autoindent comments&
autocmd FileType c,cpp  setlocal formatoptions=tcqln cindent
autocmd FileType c,cpp  setlocal cino=N-s,g0,:0,(1s,u0,m1,j1
autocmd FileType c,cpp  setlocal comments=sr:/*,mb:*,ex:*/,://

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufFilePre,BufRead *.tm set filetype=tm
autocmd BufNewFile,BufFilePre,BufRead *.sls set filetype=sls
autocmd BufNewFile,BufFilePre,BufRead *.qs set filetype=javascript
autocmd BufNewFile,BufFilePre,BufRead *.tmux set filetype=tmux

autocmd Filetype javascript,scss,sls,python,html,cpp,json setlocal sw=4 sts=4 ts=8 expandtab
autocmd Filetype make setlocal sw=8 sts=0 ts=8 noexpandtab
autocmd FileType markdown setlocal tw=0 linebreak

autocmd BufWinEnter quickfix,preview,location setlocal nornu number

" environment
set makeprg=m
set diffopt+=vertical
set backspace=indent,eol,start
set nonumber
set autoread
set relativenumber
set splitbelow
set splitright
set cindent
set hlsearch
set sw=4
set t_md=
set softtabstop=4
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*
set ts=8
set expandtab
set incsearch
set textwidth=98
set report=0
set nocompatible
set smartcase
set noequalalways
set previewheight=8
set background=dark
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set tags=.tags
set t_Co=256
set noshowmode
set noswapfile
colorscheme solarized
let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

" -----------------------------------plugins---------------------------------- "

" TABOO "
nnoremap <leader>to :TabooOpen<space>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tq :tabc<CR>
nnoremap <leader>tr :TabooRename<space>
let g:taboo_renamed_tab_format = " %N %l "
let g:taboo_tab_format = " %N %a "

" ULTISNIPS "
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/ultisnip"
let g:UltiSnipsSnippetDirectories=["ultisnip"]
nnoremap <leader>ue :UltiSnipsEdit<CR>

" EASYMOTION "
map <Leader>em <Plug>(easymotion-prefix)

" ACK.VIM "
let g:ack_qhandler = "call OpenQuickfix('')"
let g:ack_lhandler = "call OpenLocation()"
let g:ack_default_options = " -s -H --nocolor --nogroup --column ".
    \"--ignore-dir={.ccls-cache,__pycache__}"

" FUGITIVE "
nnoremap <leader>gs     :sp<CR>:Gedit :<CR>
nnoremap <leader>ga     :Git add .<CR>
nnoremap <leader>gb     :Gblame<CR>
nnoremap <leader>gc     :Git diff<CR>
nnoremap <leader>gd     :Gdiff!<CR>
nnoremap <leader>gu     :Git push<CR>
nnoremap <leader>gl     :Git! log -p<CR>
nnoremap <leader>gr     :GDelete<CR>
nnoremap <leader>ge     :Gedit %<CR>
nnoremap <leader>gm     :GMove
nnoremap <leader>gf     :Git pull --ff-only<CR>
nnoremap <leader>du	:diffupdate<CR>
nnoremap <leader>dg     :diffget 
nnoremap <leader>gh :0Gllog<CR>:call OpenLocation()<CR>

" GDB "
nnoremap <leader>de	:sp ~/dbg/.break<CR>
nnoremap <leader>da	:silent !echo break %:t:<C-r>=line('.')<CR> >> ~/dbg/.break<CR>:redr!<CR>:echom
			\ "breakpoint set at" line('.')<CR>

" AIRLINE "
let g:airline_section_c = "%{winnr()} %{expand('%')}"
let g:airline_section_x = airline#section#create_right(['readonly', 'filetype'])
let g:airline#extensions#tagbar#enabled = 0
set laststatus=2
set encoding=utf-8
set t_Co=256

" GUTENTAGS "
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_exclude = ['.git', '.ccls-cache', 'node_modules', '.pyenv']
let g:gutentags_project_root = ['.guten-root']

" INDENTLINE "
nnoremap <leader>it     :IndentLinesToggle<CR>
let g:indentLine_enabled = 0


" ALE "
function! ALEToggleFix()
    if !exists("b:ale_fix_on_save") || b:ale_fix_on_save == 1
        let b:ale_fix_on_save = 0
        echo "Disabled ALEFix on Save for buffer"
    else
        let b:ale_fix_on_save = 1
        echo "Enabled ALEFix on Save for buffer"
    endif
endfunction

set completeopt=menu,menuone,preview,noinsert
autocmd FileType * set omnifunc=ale#completion#OmniFunc
nnoremap <C-]> :ALEGoToDefinition<CR>
nnoremap <C-w><C-]> :ALEGoToDefinition -split<CR>
nnoremap g<C-w><C-]> :ALEGoToDefinition -tab<CR>
nnoremap g<C-]> :tag <C-R><C-W><CR>
autocmd FileType help map <buffer> <C-]> :tag <C-R><C-W><CR>
nnoremap <leader>ar :ALEFindReferences<CR>
nnoremap <leader>az :ALESymbolSearch<CR>
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ad :ALEDetail<CR><C-w>p
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>ai :ALEInfoToFile /tmp/ale-info<CR>:sp /tmp/ale-info<CR>
nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>
nnoremap <leader>al :ALELint<CR>
nnoremap <leader>ags :ALEGoToDefinition -split
nnoremap <leader>agv :ALEGoToDefinition -vsplit
nnoremap <leader>lr :ALERename
nnoremap <leader>ata :ALEToggle<CR>
nnoremap <leader>atb :ALEToggleBuffer<CR>
nnoremap <leader>atf :call ALEToggleFix()<CR>

inoremap <C-e> <C-\><C-o>:ALEHover<CR>
autocmd CompleteDone * ALEHover
let g:ale_hover_to_preview=1
let g:ale_completion_enabled=1
let g:ale_completion_delay=2000
let g:ale_cursor_detail=0
let g:ale_close_preview_on_insert=0
let g:ale_cpp_gcc_options='-std=c++17 -Wall -Wextra -Werror'
let g:ale_completion_max_suggestions=100
let g:ale_fix_on_save=1
let g:ale_set_loclist=0
let g:ale_linters = {
        \ 'python': ['pylsp', 'mypy', 'bandit', 'pylint'],
	\ 'cpp': ['ccls', 'clang', 'clangcheck', 'clangtidy', 'clazy', 'cppcheck',
        \       'flawfinder', 'gcc'],
        \ 'javascript': ['tsserver', 'eslint', 'jshint']
	\ }
let g:ale_fixers = {
	\ 'python': ['black', 'isort'],
	\ 'cpp': ['clang-format'],
	\ 'javascript': ['prettier']
	\ }
let g:ale_c_clangformat_options = '-style=file'
if filereadable(glob("./compile_commands.json"))
    let g:ale_c_parse_compile_commands=1
    let g:ale_c_parse_makefile=0
else
    let g:ale_c_parse_compile_commands=0
    let g:ale_c_parse_makefile=1
endif
let g:ale_python_black_options = '--line-length 98'
let g:ale_python_mypy_ignore_invalid_syntax = 1
autocmd FileType python let b:ale_python_pylint_options =
    \ '--init-hook="import sys; sys.path.insert(0, '''. expand('%:p:h') . ''')"'
let g:ale_javascript_prettier_options = '--tab-width 4'
" ALTERNATE "
nnoremap <leader>a<CR>  :A<CR>
nnoremap <leader>as  :AS<CR>
nnoremap <leader>av  :AV<CR>
let g:alternateSearchPath = 'wdr:./include,wdr:./src'

" CTRLP "
let g:ctrlp_custom_ignore = { 'file':
    \ '\v(moc_.+\.cpp|\.(o|dll|exe|out|vcproj|a|d|time|obj))$',
    \ 'dir': '\v[\/](obj|\.git|\.ccls-cache|node_modules|CMakeFiles|CMakeCache|__pycache__)$'   }
let g:ctrlp_map = '<C-f>'
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_match_current_file = 1

" NERDTREE "
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nq :NERDTreeClose<CR>
nnoremap <leader>no :NERDTree<CR>
nnoremap <leader>nn :set switchbuf=useopen<CR>:sbuf NERD<CR>:set switchbuf=<CR>
let NERDTreeMapActivateNode = 'i'
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeDirArrows=1
let NERDTreeShowLineNumbers=0
let NERDTreeStatusline="%{ getcwd() }"
let NERDTreeIgnore=['\~$', '\.d$[[file]]', '\.o$[[file]]', '\.a$[[file]]', '^moc_[[file]]',
    \ '\.time$[[file]]', '\.out$[[file]]', '\.pyenv$[[dir]]', '__pycache__[[dir]]',
    \ '\.pyc$[[file]]']
let NERDTreeWinSize=50
let NERDTreeWinPos="right"
let NERDTreeMapJumpNextSibling='<C-N>'
let NERDTreeMapJumpPrevSibling='<C-P>'

" TAGBAR "
nnoremap <leader>bf :TagbarShowTag<CR>
nnoremap <leader>bo :TagbarOpen<CR>
nnoremap <leader>bq :TagbarClose<CR>
nnoremap <leader>bb :set switchbuf=useopen<CR>:sbuf __Tagbar__<CR>:set switchbuf=<CR>
let g:tagbar_show_linenumbers=2
let g:tagbar_sort=0
let g:tagbar_left=1
let g:tagbar_width=50
let g:tagbar_show_linenumbers=1

" ZEAVIM "
nnoremap <leader>zs :Zeavim!<CR><CR>
nnoremap <leader>zk :Zeavim!<CR><CR>
nnoremap <leader>zd :Zeavim!<CR>
nnoremap <leader>zz :Zeavim<CR>
let g:zv_file_types = {
	\ 'cpp': 'cpp,qt',
	\ 'sh': 'bash',
	\ 'scss': 'sass',
	\ 'tex': 'latex',
	\ 'javascript': 'react,javascript'
	\ }

" TAG LOADING "
for f in split(glob('~/.tags/*.tags'), '\n')
    exe 'set tags+=' . f
endfor
for f in split(glob('~/.tags/*.path'), '\n')
    for line in readfile(f)
        exe 'set path+=' . line
    endfor
endfor

" LOCAL CONFIG "
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

if filereadable(glob("./.vimrc.dir"))
    source ./.vimrc.dir
endif
