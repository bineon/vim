" Modeline and Notes {
" vim: set foldmarker={,} foldmethod=marker :
"
"                    __ _ _____              _
"         ___ _ __  / _/ |___ /      __   __(_)_ __ ___
"        / __| '_ \| |_| | |_ \ _____\ \ / /| | '_ ` _ \
"        \__ \ |_) |  _| |___) |_____|\ V / | | | | | | |
"        |___/ .__/|_| |_|____/        \_/  |_|_| |_| |_|
"            |_|
"
"   This is the personal .vimrc file of Steve Francia.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://spf13.com
" }

" Environment {
    " Basics {
        set nocompatible        " must be first line
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Setup Bundle Support {
    " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
    " }

" }

" Bundles {
    " Use local bundles if available {
        if filereadable(expand("~/.vimrc.bundles.local"))
            source ~/.vimrc.bundles.local
        endif
    " }
    " Use fork bundles if available {
        if filereadable(expand("~/.vimrc.bundles.fork"))
            source ~/.vimrc.bundles.fork
        endif
    " }
    " Use bundles config {
        if filereadable(expand("~/.vimrc.bundles"))
            source ~/.vimrc.bundles
        endif
    " }
" }

" General {
    set background=dark         " Assume a dark background
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    scriptencoding utf-8
    set ambiwidth=double
    set fileencodings=ucs-bom,utf-8,gbk
    set fileformats=unix,dos,mac

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set hidden                      " allow buffer switching without saving

    " Setting up the directories {
        set backup                      " backups are nice ...
        set noswapfile                  " swapfile is annoying
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif

    " To disable views set
    " g:spf13_no_views = 1
    " in your .vimrc.bundles.local file"
    if !exists('g:spf13_no_views')
        " Add exclusions to mkview and loadview
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
            \ '[example pattern]'
            \ ]
    endif
    " }
" }

" Vim UI {
    if filereadable(expand("~/.vim/bundle/molokai/colors/molokai.vim"))
        color molokai                 " load a colorscheme
    endif

    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set foldenable                  " auto fold code
    set wildignore+=*-target,target,tmp_* " ignore temp directories

" }

" Formatting {
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType css,less,vm,vim,c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" }

" Key (re)Mappings {

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cd. lcd %:p:h

    " Paste yank register {
        nmap gp "0p
        nmap gP "0P
    " }

    " Delete to blackhole {
        nmap gd "_d
        nmap gD "_D
    " }

    " map double j to <esc>
    imap <silent> jj <esc>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Emacs style command line course move {
        cmap <C-A> <Home>
        cmap <C-E> <End>
    " }

    " Visual block search {
        function! VisualSearch(direction) range
            let l:saved_reg = @"
            execute "normal! vgvy"

            let l:pattern = escape(@", '\\/.*$^~[]')
            let l:pattern = substitute(l:pattern, "\n$", "", "")

            if a:direction == 'b'
                execute "normal ?" . l:pattern . ""
            elseif a:direction == 'f'
                execute "normal /" . l:pattern . ""
            endif

            let @/ = l:pattern
            let @" = l:saved_reg
        endfunction

        vnoremap <silent> * :call VisualSearch('f')<CR>
        vnoremap <silent> # :call VisualSearch('b')<CR>
    " }

    " Swap 0 and ^ {
        nnoremap 0 ^
        nnoremap ^ 0
        nnoremap d0 d^
        nnoremap d^ d0
        nnoremap c0 c^
        nnoremap c^ c0
        nnoremap s0 s^
        nnoremap s^ s0
        nnoremap y0 y^
        nnoremap y^ y0
    " }

    " Start shell
    map <Leader>sh :sh<CR>

    " search very magic like perl default, and use g/ to search very no magic
    nnoremap g/ /\v
    nnoremap g? ?\v
" }

" Plugins {

    " Matchit {
        let b:match_ignorecase = 1
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }

    " Switch.vim {
        nnoremap - :Switch<cr>
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
    " }

    " Ack {
        nmap <F3> :Ack <C-R><C-W>
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'zhangyc <zhangyc@fenbi.com>'

        nmap <F9> :SnipMateOpenSnippetFiles<CR>
    " }

    " Tabularize {
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a" :Tabularize /"<CR>
        vmap <Leader>a" :Tabularize /"<CR>
        nmap <Leader>a/ :Tabularize /\/<CR>
        vmap <Leader>a/ :Tabularize /\/<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
     " }

     " ZenCoding {
        let g:user_zen_leader_key = '<c-k>'
     " }

     " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
     " }

     " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
     " }

     " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
     " }

     " ctrlp {
        nmap <silent> <C-j> :CtrlPTag<cr>
        nmap <silent> <space> :CtrlPMRUFiles<cr>

        let g:ctrlp_regexp = 1
        let g:ctrlp_cmd = 'CtrlPMixed'
        let g:ctrlp_max_files = 10000
        let g:ctrlp_working_path_mode = 'ra'

        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }

        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }
     "}

     " PythonMode {
     " Disable if python support not present
        if !has('python')
           let g:pymode = 1
        endif
     " }

     " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
     "}

     " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        let g:undotree_SetFocusWhenToggle=1 " if undotree is opened, it is likely one wants to interact with it.
     " }

    " clang complete {
        if exists("*g:ClangUpdateQuickFix")
            let g:clang_hl_errors = 1
            let g:clang_complete_copen = 1
            let g:clang_close_preview = 1

            " call ClangUpdateQuickFix when saving c files
            autocmd BufWritePost *.c,*.h,*.cpp,*.hpp,*.cc call g:ClangUpdateQuickFix()
        endif
    " }

    " Gist {
        let g:gist_open_browser_after_post = 1
    " }

    " syntastic {
        let g:syntastic_javascript_jslint_conf = "--unparam --unused --browser --vars --nomen --indent 4 --plusplus --sloppy --predef define --predef window --predef location --predef history --predef location --predef document"
        let g:syntastic_check_on_open = 1
        let g:syntastic_enable_signs = 0
        let g:syntastic_mode_map = { 'mode': 'passive',
                    \ 'active_filetypes': ['javascript'],
                    \ 'passive_filetypes': [] }
    " }
" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " remove the toolbar
        set lines=40                " 40 lines of text instead of 24,
        if has("gui_gtk2")
            set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        else
            set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        endif
        if has('gui_macvim')
            set transparency=5          " Make the window slightly transparent
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif
" }

 " Functions {

function! UnBundle(arg, ...)
  let bundle = vundle#config#init_bundle(a:arg, a:000)
  call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
endfunction

com! -nargs=+         UnBundle
\ call UnBundle(<args>)

function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

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

" Strip whitespace
function! StripTrailingWhitespace()
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    if !exists('g:spf13_keep_trailing_whitespace')
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endif
endfunction

" }

" Use fork vimrc if available {
    if filereadable(expand("~/.vimrc.fork"))
        source ~/.vimrc.fork
    endif
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }
