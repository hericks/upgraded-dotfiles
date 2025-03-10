" VimPlug {{{

  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.config/nvim/plugged')

    " Easy comments
    Plug 'tomtom/tcomment_vim'

    " Color scheme
    Plug 'rakr/vim-one'

    " Vim airline
    Plug 'vim-airline/vim-airline'

  call plug#end()
" }}}

" General {{{

  " Line numbers
    set number
    set nowrap

  " Use spaces instead of tabs
    set expandtab tabstop=2 shiftwidth=2

  " Improved search
    set hlsearch
    set ignorecase

  " Indent
    set autoindent
    filetype plugin indent on

  " Fold method
    set foldmethod=marker

  " Copy and paste to system clipboard
    set clipboard=unnamed

  " Clean directories
    set noswapfile

  " Natural split
    set splitright splitbelow

" }}}

" Appearance {{{

  " Colorscheme related
  set termguicolors
  set background=dark

  silent! colorscheme one

  " Highlight cursorline
  set cursorline


  " Display unwanted characters
  set list listchars=tab:▸\ ,trail:·,extends:»,precedes:«
  silent! call one#highlight('ExtraWhitespace', 'e06c75', '', '')
  silent! match ExtraWhitespace /\s\+$/

  " vim-airline related
  let g:airline_left_sep='▹'
  let g:airline_right_sep='◀︎'

  if filereadable(expand("$HOME/.config/nvim/plugged/vim-one"))
    let g:airline_theme='one'
  endif

" }}}

" Functions {{{

  " OpenInSplitIfBufferDirty(file) {{{
    function! OpenInVSplitIfBufferDirty(file)
      if line('$') == 1 && getline(1) == ''
        exec 'edit' a:file
      else
        exec 'vsplit' a:file
      endif
    endfunction

  " }}}

  " LeftVerticalMotion(stepSize) {{{
    function! LeftVerticalMotion(stepSize)
      " Original cursor position/column
      let originalPosition=getcurpos()
      let originalColumn=originalPosition[2]

      " Leftmost non-whitespace column
      normal! ^
      let leftmostNWColumn=getcurpos()[2]

      " Rightmost non-whitespace column
      normal! g_
      let rightmostNWColumn=getcurpos()[2]

      " Rightmost column
      normal! $
      let rightmostColumn=getcurpos()[2]

      if (originalColumn > rightmostNWColumn)
        normal g_
      elseif (originalColumn > leftmostNWColumn + a:stepSize)
        call setpos('.', originalPosition)
        execute "normal!" a:stepSize . "h"
      elseif (originalColumn > leftmostNWColumn)
        normal! ^
      elseif (originalColumn > 1)
        normal! 0
      else
        normal! $
      endif
    endfunction
    " }}}

  " RightVerticalMotion(stepSize) {{{
    function! RightVerticalMotion(stepSize)
      " Original cursor position/column
      let originalPosition=getcurpos()
      let originalColumn=originalPosition[2]

      " Leftmost non-whitespace column
      normal! ^
      let leftmostNWColumn=getcurpos()[2]

      " Rightmost non-whitespace column
      normal! g_
      let rightmostNWColumn=getcurpos()[2]

      " Rightmost column
      normal! $
      let rightmostColumn=getcurpos()[2]

      if (originalColumn < leftmostNWColumn)
        normal! ^
      elseif (originalColumn < rightmostNWColumn - a:stepSize)
        call setpos('.', originalPosition)
        execute "normal!" a:stepSize . "l"
      elseif (originalColumn < rightmostNWColumn)
        normal! g_
      elseif (originalColumn < rightmostColumn)
        normal! $
      else
        normal! 0
      endif
    endfunction
  " }}}

" }}}

" Keymaps {{{

  " Leader
    let mapleader="\<Space>"

  " Quick save
    nnoremap <Leader>w :w<CR>

  " Reload and alter $MYVIMRC
    nnoremap <silent><Leader>rv :source $MYVIMRC<CR>:noh<return><ESC>:echo "Reload finished."<CR>
    nnoremap <silent><Leader>av :call OpenInVSplitIfBufferDirty($MYVIMRC)<CR>

  " Quick escape
    inoremap kj <ESC>

  " Move through wrapped lines
    noremap j       gj
    noremap <DOWN>  gj
    noremap k       gk
    noremap <UP>    gk

  " Improved movement
    noremap J 5j
    noremap K 5k
    noremap <silent>H :call LeftVerticalMotion(5)<CR>
    noremap <silent>L :call RightVerticalMotion(5)<CR>

  " Enter commands quickly
    nnoremap , :

  " Use marks position instead of mark line
    nnoremap ' `

  " Enter special chars quickly
    inoremap ## \
    inoremap ö {
    inoremap Ö }
    inoremap ä (
    inoremap Ä )
    inoremap ü [
    inoremap Ü ]

  " Navigate splits
    nnoremap <Leader>h <C-W>h
    nnoremap <Leader>j <C-W>j
    nnoremap <Leader>k <C-W>k
    nnoremap <Leader>l <C-W>l

  " Move splits
    nnoremap <Leader>H <C-W>H
    nnoremap <Leader>J <C-W>J
    nnoremap <Leader>K <C-W>K
    nnoremap <Leader>L <C-W>L

  " Clear search
    nnoremap <silent><ESC> :noh<return><ESC>

  " Expant path of file currently edited into clipboard
    nnoremap <silent><Leader>cp :let @+ = expand('%:p')<CR>:echo "Path copied. (<C-R>")"<CR>

  " Show all currently active highlight groups
    nnoremap <silent><Leader>allhlt :so $VIMRUNTIME/syntax/hitest.vim<CR>

" }}}
