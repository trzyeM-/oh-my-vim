augroup vimrc
    autocmd!
augroup END

set noerrorbells visualbell t_vb=
set nobackup
set nowritebackup
set noswapfile

function s:MakeNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup MakeNonExDir
    autocmd!
    autocmd BufWritePre * :call s:MakeNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

set number
set relativenumber
autocmd vimrc InsertEnter * :set norelativenumber
autocmd vimrc InsertLeave * :set relativenumber

set scrolloff=5
set sidescrolloff=5
set autoindent
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4
set expandtab
set nojoinspaces
set gdefault
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2
set nowrap
set cursorline
set foldmethod=indent
set foldlevel=1
"set foldclose=all¬

syntax enable
"colorscheme molokai
colorscheme monokai
set background=dark

autocmd vimrc ColorScheme * :hi NonText ctermfg=236
autocmd vimrc ColorScheme * :hi SpecialKey ctermfg=236
autocmd vimrc ColorScheme * :hi ExtraWhitespace ctermbg=red guibg=red
autocmd vimrc ColorScheme * :hi Visual guibg=#00588A
autocmd vimrc ColorScheme * :hi link multiple_cursors_cursor Search
autocmd vimrc ColorScheme * :hi link multiple_cursors_visual Visual

"set listchars=trail:·,eol:¬,nbsp:_,extends:>,precedes:<
"set listchars=tab:>-,trail:.,precedes:<,extends:>¬
"set listchars=tab:%,trail:·,eol:¬,nbsp:extends:>
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:>,precedes:<

function! ToggleInvisibles()
    set nolist!
    if &list
        hi! link ExtraWhitespaceMatch ExtraWhitespace
    else
        hi! link ExtraWhitespaceMatch NONE
    endif
endfunction

set nolist
call ToggleInvisibles()

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"set rtp+=/usr/share/vim/vim74/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'bling/vim-airline'
    Plugin 'tpope/vim-fugitive'
    Plugin 'kien/ctrlp.vim'
    Bundle 'jlanzarotta/bufexplorer'
    Plugin 'joonty/vdebug'
call vundle#end()
filetype plugin indent on

let g:airline_powerline_fonts = 1
let Vimphpcs_Standard = 'PSR2'

vmap <leader>cc :s/^/#/<cr>
vmap <leader>co :s/^#//<cr>

autocmd BufWritePre * :%s/\s\+$//e

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|css|js|jpg|gif)$',
  \ 'link': '',
  \ }
